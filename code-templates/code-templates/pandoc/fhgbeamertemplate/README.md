# Fraunhofer LaTeX Beamer template
Template to create presentations in Fraunhofer corporate design with the LaTeX Beamer package. The appearance differs only slightly from the [official PowerPoint templates](https://info.fraunhofer.de/marketing-pr/corporate-design/fraunhofer-cd/Seiten/default.aspx).

## Prerequisites
* The Fraunhofer Frutiger font family must be installed on the system (e.g. in `C:\Windows\Fonts`)
* The `LuaLaTeX`-compiler must be available to use the `fontspec`-package

## Installation
* Clone the repository into your [local TeX tree](https://miktex.org/kb/texmf-roots) (`C:\Users\<username>\AppData\Local\MiKTeX\<version>\tex\latex` on Windows)
* Update the MiKTeX file name database by running `initexmf --update-fndb` in a terminal or with <kbd>Tasks</kbd>-<kbd>Refresh file name database</kbd> in MiKTeX Console
* Alternatively copy all files next to the `.tex`-file you want to compile (not recommended)

### Updates
For updates simply pull the latest version using Git in the cloned repository folder

## Usage
* Make sure to compile with `LuaLaTeX` e.g. by adding the magic command `% !TeX program = lualatex` as first line to your document if using TeXstudio
* Enable the template using `\documentclass{fhgbeamer}` or `\documentclass[9pt]{beamer} \usetheme{fhg}`

### Variables
The template uses the basic Beamer variables `\title{Title}`, `\author[short]{long}` and `\institute[short]{long}` which can be set in the document header. Others like `\date` are not included yet. The variables `\address{}`, `\homepage{}`, `skyline{}{}` and `\institutelogo{}` have been introduced additionally.

### TikZ
To navigate within a frame you can access the TikZ coordinates `(topleft)`, `(topcenter)`, `(topright)`, `(bottomleft)`, `(bottomcenter)` and `(bottomright)` defined for the upper and lower green Fraunhofer bar.

### Customization
* Place the logo of your institute in the `beamerthemefhg/img` folder (e.g. export a padding-free `.svg` file as `logo.pdf` using Inkscape) and enable it using `\institutelogo{<filename>}` in the document preamble
* The thin horizontal line on the title page may be replaced by a skyline image in `beamerthemefhg/img` and the respective city name using `\skyline{<image>}{<city>}`
* You can customize the `.sty` files according to your needs with some basic LaTeX and TikZ skills

## Contribution and Distribution
Since the template is not officially approved, this work is to be considered experimental and for personal use only. Feel free to use, edit and share. To contribute, please become a member of the [LaTeX-users group](https://gitlab.cc-asp.fraunhofer.de/latex-users/) and push your changes to a personal branch. To incorporate your changes into the master branch, please create a merge request.