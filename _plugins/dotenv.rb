# Loads a local .env so `JEKYLL_GITHUB_TOKEN` is picked up during development.
#
# jekyll-github-metadata falls back to unauthenticated API calls without a
# token, which is capped at 60 requests/hour per IP - easily exhausted by a
# couple of local builds, leaving the projects section silently empty.
#
# In CI there is no .env file; the token comes from the workflow environment
# instead, so this is a no-op there.
begin
  require "dotenv"
  Dotenv.load(File.expand_path("../.env", __dir__))
rescue LoadError
  # dotenv not installed - fall back to the ambient environment.
end

# A blank token is worse than no token at all: jekyll-github-metadata treats the
# variable as present, sends an empty credential, and the build dies on a
# confusing "401 Bad credentials" instead of quietly falling back to
# unauthenticated requests. Drop blanks so the fallback works.
%w[JEKYLL_GITHUB_TOKEN JEKYLL_GITHUB_API_TOKEN].each do |var|
  ENV.delete(var) if ENV[var] && ENV[var].strip.empty?
end
