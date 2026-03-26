# My Personal website based on Neumorphism <!-- omit in toc -->

> Neumorphism designed Jekyll theme for personal websites, portfolios, and resumes.

<!-- TABLE OF CONTENTS -->
## Table of Contents <!-- omit in toc -->

* [About The Project](#about-the-project)
  * [Built With](#built-with)
  * [Features](#features)
* [Getting Started](#getting-started)
  * [Prerequisites](#prerequisites)
  * [Installation](#installation)
* [Usage](#usage)
  * [Personalize and Customize](#personalize-and-customize)
    * [_config.yml](#_configyml)
    * [Github Metadata Plugin](#github-metadata-plugin)
    * [_data/*.yml](#_datayml)
    * [Particles.js](#particlesjs)
* [Contributing](#contributing)
* [License](#license)
* [Acknowledgements](#acknowledgements)

<!-- ABOUT THE PROJECT -->

## About The Project

This is a fork of [Neumorphism](https://github.com/longpdo/neumorphism/) built with `Jekyll` and hosted on `Github Pages`, which is based on the new `Neumorphism` design trend and was developed with a mobile-first approach. This can be used by developers who want to showcase their resumes and portfolios. If you want to use this for your own website, fork this repository and then refer to [personalize and customize](#personalize-and-customize).

### Built With

* [Jekyll](https://jekyllrb.com/)

### Features

* Mobile-First Responsive Design
* Animated preloader animation
* Landing Page with animated background with [particles.js](https://vincentgarreau.com/particles.js/), a Typing Carousel and animated social icons
* Dark Neumorphism Design on the main content
* [Animations On Scroll](https://michalsnik.github.io/aos/)
* Filterable *Skills* word cloud
* [Github's API](https://developer.github.com/v3/) automatically populating the *Open Source Projects* section
* Gulp dev workflow with [BrowserSync](https://browsersync.io/), [Autoprefixer](https://autoprefixer.github.io/) and `JS` & `SCSS` minifying.
* [Google Analytics](https://analytics.google.com/)

#### Additions to the original design
* The arrow addition is from [Will Green](https://github.com/wlg0005/wlg0005.github.io).
* Color-coded buttons on the "Skills" section.
* Single-piece hexagram design for better rendering on different devices.
* Easier and fully customizable color scheme.

<!-- GETTING STARTED -->

## Getting Started

To get a local copy up and running, follow these simple steps.

This repo has been changed to be developed and tested with a docker container. 


### Prerequisites

* [NodeJS](https://nodejs.org/en/)

* [Jekyll](https://jekyllrb.com/)

For more information, refer to [this](https://jekyllrb.com/docs/installation/).

* [Yarn](https://yarnpkg.com/)

All these will be installed when building the Docker image. 

### Installation

> Recommended way: If you want to contribute to this theme or open issues due to problems implementing this on your own, I recommend forking the repository directly. This makes it easier for me to solve open issues and questions or check pull requests.

1.1: Fork the repository (using the `Fork` button at the top), create your own repository, and then clone the repository

```sh
# Replace {YOUR_USERNAME}, {YOUR_REPOSITORY} with the actual values
git clone https://github.com/{YOUR_USERNAME}/{YOUR_REPOSITORY}.git
```

2: Change the directory into neumorphism

```sh
cd {YOUR_REPOSITORY}
```

3: Set up the Docker container. (Depending on your system settings, Docker commands might need sudo privileges.)

```sh
docker build -t {DOCKER_IMAGE_NAME_OF_YOUR_CHOICE} .
```

4: After it is built, run:
```sh
docker run --volume="${PWD}:/srv" -p 4000:4000 -it {DOCKER_IMAGE_NAME_OF_YOUR_CHOICE} /bin/bash -c "yarn; bundle install; bundle update"
```

5: The previous step needs to be committed to your Docker image. Find the stopped docker container with the changes made by the command you run. Run the below command and find the line that has the image name you have given and the command you just ran. `yarn; bundle install; bundle update`
```sh
docker container list -a
```
It will show an output something like this:
```
{SOME_HEX_STTRING}  {DOCKER_IMAGE_NAME_OF_YOUR_CHOICE}    "/bin/bash -c 'yarn;…"   2 hours ago      Exited (0) 2 seconds ago    modest_green    
```
Copy the string in the first column `{SOME_HEX_STTRING}`.

6: Commit those changes to your image
```sh
docker commit {SOME_HEX_STTRING}  {DOCKER_IMAGE_NAME_OF_YOUR_CHOICE}
```

Your image is ready.

<!-- USAGE EXAMPLES -->

## Usage

* Run and develop locally with the live server at `http://localhost:4000`; this will also build production-ready `JS` and `SCSS` assets with every change

```sh
docker run --rm --volume="${PWD}:/srv" -p 4000:4000 --name {NEW_CONTAINER_NAME} -it {DOCKER_IMAGE_NAME_OF_YOUR_CHOICE} gulp 
```

 
* After committing and pushing, see your repository's `Settings` page to see where your site is published via `Github Pages`.
* This version also has the Github actions enabled.

### Personalize and Customize

#### _config.yml

Edit `_config.yml` to personalize your site. For documentation, refer to `docs/config.md`.

#### Github Metadata Plugin

If you want your Github repositories automatically pulled for the Open Source Projects section, you also need to authenticate yourself for the Github Metadata plugin to work.

You need to generate a new personal access token on GitHub:

* Go to the [Github Token site](https://github.com/settings/tokens/new)
* Select the scope `public_repository`, and add a description.
* Confirm and save the settings. Copy the token you see on the page.
* Create a `.env` file inside your repository and add your generated `JEKYLL_GITHUB_TOKEN`:

```text
JEKYLL_GITHUB_TOKEN=0YOUR0GENERATED0TOKEN0
```

To complete the configuration for the Github Metadata plugin, you also need to change the value of `repository` inside `_config.yml`. After this, you should ensure the GitHub Metadata plugin works properly.

For optimal results, you should make sure that every Github project you want to be included in this portfolio has added the following pieces of information on GitHub:

* Description
* Homepage link, if there is a live version of it
* Topics

Example:
![Github Repository Information Example][github-repo-info]

#### _data/*.yml

Edit files inside `_data` to add information to the portfolio. For documentation, refer to [docs/data.md](https://github.com/longpdo/neumorphism/blob/master/docs/data.md).

#### Particles.js

Edit `assets/particles.json` to customize the landing page background animation. For more information, refer to [this](https://github.com/VincentGarreau/particles.js/#options).

<!-- CONTRIBUTING -->

## Contributing

For contributions, see [original project page](https://github.com/longpdo/neumorphism/).


<!-- LICENSE -->

## License

Distributed under the MIT License. See `LICENSE` for more information.

<!-- ACKNOWLEDGEMENTS -->

## Acknowledgements

* [Font Awesome](https://fontawesome.com/)
* [Normalize.css](https://necolas.github.io/normalize.css/)
* Based Preloader on [Codrin Pavel's](https://codepen.io/zerospree/pen/aCjAz) version
* Typing Carousel by [Gregory Schier](https://codepen.io/gschier/pen/jkivt)
* Social Button Animation by [Stéphane Lyver](https://codepen.io/wouwi/pen/Lwrmi)
* Adapted [Damian Jankowski's](https://codepen.io/dolaron/pen/rNadmOE) color palette for the neumorphism design
* Based Timeline on [Krishna Babu's](https://codepen.io/krishnab/pen/OPwqbW) version
* The arrow addition is from [Will Green](https://github.com/wlg0005/wlg0005.github.io).

<!-- MARKDOWN LINKS & IMAGES -->

[product-screenshot]: https://raw.githubusercontent.com/longpdo/neumorphism/master/docs/screenshot.gif
[github-repo-info]: https://raw.githubusercontent.com/longpdo/neumorphism/master/docs/github-repo-info.png
