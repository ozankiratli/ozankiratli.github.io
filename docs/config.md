# Documentation for _config.yml

## General Site Settings

* `title`: This will be displayed as the website's name in your browser tab.
* `description`: This will be meta HTML tag content. This can be ignored.
* `baseurl`: The subpath of your site
  * set this to **""**, if you renamed the repository to `<user>.github.io`

## Landing Page

* `username`: This will displayed on the landing page as your name.

* `typing_text`: This will be text, which will be typed before *scroll down for more*.
  * set this to your job title, e.g. **Fullstack Developer**
* `email`: Your E-Mail address for the email button.
* Social Link buttons:
  * For every social button you want to display, set your username or userid
  * Usernames or ids can usually be taken from your profile links
  * If you do not use one of the following websites, then leave it empty
  * e.g. since I don't blog on dev.to or have Twitter my configs are like this:
    * `github_username`: **longpdo**
    * `codepen_username`: **longpdo**
    * `dev_username`:
    * `linkedin_username`: **longpdo**
    * `twitter_username`:

## About Me Section

* `show_aboutme_card`:
  * setting this to **true**, will display the About Me section
  * setting this to **false**, will omit the About Me section
* `about_me_title`: The will be displayed as the title in the About Me section
* `about_me_description`: This will be displayed under the title.
  * You can add and style website links with this HTML template inside every **section_description**, e.g. checkout the current `about_me_description`:

  ```html
  <a class="highlight-link" href="https://github.com/longpdo/neumorphism" target="_blank" rel="noreferrer"> Github </a>
  ```

## Skills Section

* `show_skills_card`:
  * setting this to **true**, will display the Skills section
  * setting this to **false**, will omit the Skills section
* `about_me_title`: The will be displayed as the title in the Skills section

## Timeline Section

* `show_timeline_card`:
  * setting this to **true**, will display the Timeline section
  * setting this to **false**, will omit the Timeline section
* `timeline_title`: The will be displayed as the title in the Timeline section
* `cv_download_link`: The link where you host your cv.

## Projects Section

* `show_projects_card`:
  * setting this to **true**, will display the Projects section
  * setting this to **false**, will omit the Projects section
* `show_projects`:
  * setting this to **true**, will display your listed projects in _data/projects.yml
  * setting this to **false**, will omit your listed projects
* `projects_title`: The will be displayed as the title of your projects
* `show_os_projects`:
  * setting this to **true**, will display your public projects on github
  * setting this to **false**, will omit your public projects on github
* `os_projects_title`: The will be displayed as the title of your open source projects

## Contact Section

* `show_contact_card`:
  * setting this to **true**, will display the Contact section
  * setting this to **false**, will omit the Contact section
* `contact_title`: The will be displayed as the title in the Contact section
* `contact_description`: This will be displayed under the title.

## Github Metadata

* `repository`:
  * Set this to your forked repository
  * e.g. `<user>/<user>.github.io`
* `projects`:
  * `sort_by`: sorting for the non-featured repositories. Takes **one** value, not a list.
    * set this to **stars**, to sort by stars first, with the most recent push breaking ties.
    * set this to **pushed**, to sort by last push first, with stars breaking ties.
    * any other value behaves as **pushed**. Note a list such as `stars, pushed` is read as the single string `"stars, pushed"`, matches neither, and silently falls back to **pushed**.
  * `featured`: a list of repository names to pin above the rest, rendered in exactly the order given.
    * these are looked up in the *full* repository list, so a featured repository still shows even if it is a fork or archived — `exclude.archived` and `exclude.forks` do **not** hide it.
    * featured repositories are removed from the main list, so they never appear twice.
    * they are marked visually by title color, not a separate heading.
    * omit the key or leave the list empty to disable the feature entirely.
  * `exclude`:
    * `archived`:
      * setting this to **true**, will exclude archived repositories
      * setting this to **false**, will also display archived repositories
    * `forks`:
      * setting this to **true**, will exclude forked repositories
      * setting this to **false**, will also display forked repositories
    * `projects`: A list of the repository names you want to exclude from the listing.

## Google Analytics

Removed from this fork. The `id` key is no longer read and there is no tracking code in the layouts.
