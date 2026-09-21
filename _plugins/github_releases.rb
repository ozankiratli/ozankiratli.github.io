# frozen_string_literal: true

require "fileutils"
require "set"
require "json"
require "net/http"
require "uri"

# Publishes the latest release of each Github project as
# `site.data.github_releases`, keyed by repository name:
#
#   site.data.github_releases["PoolSeqFlow"]
#   #=> { "tag" => "v3.1.1", "url" => "https://github.com/.../releases/tag/v3.1.1" }
#
# jekyll-github-metadata already supplies the repository list, but a repository
# object from the Github API carries no release data at all, so the version has
# to be fetched separately, one request per project.
#
# /releases/latest reports the newest release that is neither a draft nor a
# prerelease, which is the definition of "published version" the cards want.
# Repositories with no releases answer 404: they are left out of the map and
# their cards render without a version line. That is the ordinary case, not an
# error - most projects here have never cut a release.
#
# Nothing in here is allowed to fail a build. A dead network, a spent rate
# limit or a bad token costs the version line and nothing else.
module GithubReleases
  API_HOST = "api.github.com"

  # Results are cached on disk so gulp's rebuild-on-save loop does not re-query
  # the API on every edit. Unauthenticated callers get 60 requests/hour per IP
  # and this costs about one request per project - the same budget problem
  # _plugins/dotenv.rb exists to avoid.
  CACHE_TTL = 3600

  # Short enough that an unreachable API delays a build by seconds rather than
  # stalling it.
  OPEN_TIMEOUT = 5
  READ_TIMEOUT = 10

  class << self
    def for_site(site)
      login = site.config["github_username"].to_s
      return {} if login.empty?

      cache = Cache.new(site)
      fresh = cache.read
      return fresh if fresh

      begin
        releases = fetch_all(login, skip: excluded(site))
      rescue StandardError => e
        Jekyll.logger.warn "GithubReleases:", "#{e.class}: #{e.message} - falling back to cache"
        # A stale answer beats no answer: versions change rarely, so last
        # build's numbers are almost certainly still correct.
        return cache.read(:ignore_age) || {}
      end

      cache.write(releases)
      releases
    end

    private

    # Repositories named in `projects.exclude.projects` never reach a card, so
    # asking about their releases is a wasted request. This is a plain name
    # match on the same list _includes/section-projects.html filters by; the
    # archived/fork rules stay in the template, where they already live.
    def excluded(site)
      projects = site.config["projects"] || {}
      exclude = projects["exclude"] || {}
      Array(exclude["projects"]).map(&:to_s).to_set
    end

    def fetch_all(login, skip:)
      repos(login).each_with_object({}) do |name, map|
        next if skip.include?(name)

        release = get("/repos/#{login}/#{name}/releases/latest")
        next if release.nil? # 404 - no published release

        map[name] = { "tag" => release["tag_name"], "url" => release["html_url"] }
      end
    end

    def repos(login)
      names = []
      page = 1
      loop do
        batch = get("/users/#{login}/repos?per_page=100&type=owner&page=#{page}")
        break if batch.nil? || batch.empty?

        names.concat(batch.map { |repo| repo["name"] })
        break if batch.length < 100

        page += 1
      end
      names
    end

    # Both variables are read so a token set for jekyll-github-metadata is
    # picked up here too, rather than needing its own.
    def token
      %w[JEKYLL_GITHUB_TOKEN JEKYLL_GITHUB_API_TOKEN]
        .map { |name| ENV[name] }
        .find { |value| value && !value.strip.empty? }
    end

    def get(path)
      uri = URI::HTTPS.build(host: API_HOST, path: path.split("?").first, query: path.split("?")[1])
      request = Net::HTTP::Get.new(uri)
      request["Accept"] = "application/vnd.github+json"
      request["User-Agent"] = "ozankiratli.github.io"
      found = token
      request["Authorization"] = "Bearer #{found}" if found

      response = Net::HTTP.start(
        uri.host, uri.port,
        :use_ssl => true, :open_timeout => OPEN_TIMEOUT, :read_timeout => READ_TIMEOUT
      ) { |http| http.request(request) }

      case response
      when Net::HTTPSuccess  then JSON.parse(response.body)
      when Net::HTTPNotFound then nil
      else raise "GET #{path} -> HTTP #{response.code}"
      end
    end
  end

  # A single JSON file under .jekyll-cache (gitignored), holding the map and
  # the time it was fetched.
  class Cache
    def initialize(site)
      @path = site.in_source_dir(".jekyll-cache", "github-releases.json")
    end

    # Returns nil when there is no usable cache, so callers can tell "no cache"
    # from "cached, and the answer is that nothing has a release" ({}).
    def read(ignore_age = nil)
      return nil unless File.file?(@path)

      payload = JSON.parse(File.read(@path))
      return nil unless ignore_age || Time.now.to_i - payload["fetched_at"].to_i < CACHE_TTL

      payload["releases"]
    rescue StandardError
      nil # unreadable or malformed - treat as a cold cache
    end

    def write(releases)
      FileUtils.mkdir_p(File.dirname(@path))
      File.write(@path, JSON.pretty_generate("fetched_at" => Time.now.to_i, "releases" => releases))
    rescue StandardError => e
      Jekyll.logger.warn "GithubReleases:", "could not write cache: #{e.message}"
    end
  end
end

module Jekyll
  class GithubReleasesGenerator < Generator
    safe true

    def generate(site)
      site.data["github_releases"] = GithubReleases.for_site(site)
    end
  end
end
