# Fraunhofer LaTeX

This package provides a style definition for typesetting documents in Fraunhofer corporate design.  The package supports the document classes provided by the `koma-script` bundle and the `beamer` package.  Posters can be typeset invoking the `beamerposter` package.  Defaults for over 70 Fraunhofer research institutions are included.  The package also implements additional color names and provides a macro to typeset the Fraunhofer logo.  This package does not implement the *Frutiger* font.  For the latter, please refer to the `frutiger` package which can be found [here](https://gitlab.cc-asp.fraunhofer.de/mboljen/frutiger-latex.git).



## Table of Contents

* [About the Project](#about-the-project)
* [Getting started](#getting-started)
  * [Prerequisites](#prerequisites)
* [Installation](#installation)
  * [Extract from TDS archive](#extract-from-tds-archive)
  * [Building from scratch](#building-from-scratch)
* [Usage](#usage)
* [Roadmap](#roadmap)
* [Contributing](#contributing)
* [License](#license)
* [Contact](#contact)
* [Acknowledgements](#acknowledgements)



## About the Project

These files were developed to typeset scientific documents in LaTeX according to the requirements of Fraunhofer corporate design.  Since no document classes and package files were available at the time I needed them, I started to build them on my own.

The files provided by the `fraunhofer` bundle are the result of several years of development and include contributions of many colleagues.  We hope that these files are useful to colleagues at other Fraunhofer institutes as well.  This project was started to enable experienced [LaTeX](https://www.latex-project.org) users to author their Fraunhofer documents with a typesetting system of their choice and to relieve them from the overhead inheritly required by ordinary [WYSIWYG](https://en.wikipedia.org/wiki/WYSIWYG)-based word processors.



## Getting started

A reasonably recent LaTeX distribution is required, e.g. acquire an installation of [TeX Live](https://tug.org/texlive/), [MiKTeX](https://miktex.org/) or [MacTeX](https://tug.org/mactex).


### Prerequisites

The following LaTeX packages are mandatory for using the package:

+ [beamer](https://ctan.org/pkg/beamer) - LaTeX class for producing presentations and slides
+ [beamerposter](https://ctan.org/pkg/beamerposter) - Extend `beamer` and `a0poster` for custom sized posters
+ [changepage](https://ctan.org/pkg/changepage) - Margin adjustment and detection of odd/even pages
+ [geometry](https://ctan.org/pkg/geometry) - Flexible and complete interface to document dimensions
+ [koma-script](https://ctan.org/pkg/koma-script) - A bundle of versatile classes and packages
+ [lastpage](https://ctan.org/pkg/lastpage) - Reference last page for Page N of M type footers
+ [microtype](https://ctan.org/pkg/microtype) - Subliminal refinements towards typographical perfection
+ [nfssext-cfr](https://ctan.org/pkg/nfssext-cfr) - Extensions to the LaTeX NFSS
+ [oberdiek](https://ctan.org/pkg/oberdiek) - A bundle of packages submitted by Heiko Oberdiek
+ [svn-prov](https://ctan.org/pkg/svn-prov) - Subversion variants of `\Provides...` macros
+ [xcolor](https://ctan.org/pkg/xcolor) - Driver-independent color extensions for LaTeX and pdfLaTeX

The following LaTeX packages are recommended:

+ [digsig](http://home.htp-tel.de/lottermose2/tex/dist/digsig.sty) - LaTeX macros for digital signature fields in PDF files
+ [frutiger](http://gitlab.cc-asp.fraunhofer.de/mboljen/frutiger-latex) - Using Linotype Frutiger fonts with LaTeX
+ [url](https://ctan.org/pkg/url) - Verbatim with URL-sensitive line breaks



## Installation

In order to install the package, you have two options:

1. Download and extract files from TDS-compliant archive `fraunhofer.tds.zip`.
2. Build the files from scratch.


### Download and extract from ZIP archive

Download the TDS-compliant archive `fraunhofer.tds.zip`:

+ [fraunhofer-tds (master)](../-/jobs/artifacts/master/raw/fraunhofer.tds.zip?job=build)
+ [fraunhofer-tds (v1.6.0)](../-/jobs/artifacts/v1.6.0/raw/fraunhofer.tds.zip?job=build)

and unzip the file to a folder searched by TeX.  Refresh the filename database to make TeX aware of the new files.  That's it.

```sh
$ unzip fraunhofer.tds.zip -d /some/where/texmf
$ mktexlsr
```


### Building files from scratch

For building the TDS-compliant archive `fraunhofer.tds.zip` from source `fraunhofer.dtx`, the following prerequisites need to be met.

#### Prerequisites

The following tools are mandatory:

+ [inkscape](https://inkscape.org) - Free and open-source vector graphics editor

The following LaTeX packages are required for building the documentation:

+ [booktabs](https://ctan.org/pkg/booktabs) - Publication quality tables in LaTeX
+ [caption](https://ctan.org/pkg/caption) - Customising captions in floating environments
+ [datetime2](https://ctan.org/pkg/datetime2) - Formats for dates, times and time zones
+ [enumitem](https://ctan.org/pkg/enumitem) - Control layout of itemize, enumerate, description
+ [hologo](https://ctan.org/pkg/hologo) - A collection of logos with bookmark support
+ [l3packages](https://ctan.org/pkg/l3packages) - High-Level LaTeX3 concepts
+ [lipsum](https://ctan.org/pkg/lipsum) - Easy access to the Lorem Ipsum dummy text
+ [marginnote](https://ctan.org/pkg/marginnote) - Notes in the margin, even where \marginpar fails
+ [sourceserifpro](https://ctan.org/pkg/sourceserifpro) - Use font *SourceSerifPro*
+ [threeparttable](https://ctan.org/pkg/threeparttable) - Tables with captions and notes all the same width

#### Clone the repository

The first step is to get a copy of the repository:

```sh
$ git clone https://gitlab.cc-asp.fraunhofer.de/mboljen/fraunhofer-latex
```

#### Build and Installation

The installation process is organized using a simple Makefile.  In order to build the package and install the generated files to your local TeX environment, run the following commands:

```sh
$ make
$ make install
```

You can customize the installation by selecting another destination folder via the variable `INSTALLTEXMF`, otherwise suitable locations will be determined automatically.  If you run the above commands via `sudo`, the installation will be made available to all users.

#### Uninstall

In order to uninstall the package, run the following command.  All files will be removed from your local TeX installation.

```sh
$ make uninstall
```



## Usage

Please consult the manual for details.  If you already installed the package to your TeX installation you can submit the following command:

```sh
$ texdoc fraunhofer
```

Download the documentation as PDF document:

+ [fraunhofer-doc (master)](../-/jobs/artifacts/master/raw/fraunhofer.pdf?job=build)
+ [fraunhofer-doc (v1.6.0)](../-/jobs/artifacts/v1.6.0/raw/fraunhofer.pdf?job=build)



## Demos

Example files are available by submitting the following commands:

```sh
$ pdflatex fraunhofer-article
$ pdflatex fraunhofer-beamer
$ pdflatex fraunhofer-book
$ pdflatex fraunhofer-letter
$ pdflatex fraunhofer-poster
$ pdflatex fraunhofer-report
```

The latest builds of these examples are available as PDF documents for download here:

+ [fraunhofer-article](../-/jobs/artifacts/master/raw/fraunhofer-article.pdf?job=build)
+ [fraunhofer-beamer](../-/jobs/artifacts/master/raw/fraunhofer-beamer.pdf?job=build)
+ [fraunhofer-book](../-/jobs/artifacts/master/raw/fraunhofer-book.pdf?job=build)
+ [fraunhofer-letter](../-/jobs/artifacts/master/raw/fraunhofer-letter.pdf?job=build)
+ [fraunhofer-poster](../-/jobs/artifacts/master/raw/fraunhofer-poster.pdf?job=build)
+ [fraunhofer-report](../-/jobs/artifacts/master/raw/fraunhofer-report.pdf?job=build)



## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.



## License

This software is licensed under the [MIT](https://choosealicense.com/licenses/mit/) license.



## Contact

E-Mail: [matthias.boljen@emi.fraunhofer.de](mailto:matthias.boljen@emi.fraunhofer.de)



## Acknowledgements

+ Christian Hemminghaus
+ Johanna Holz
+ Clemens Horch
+ Felix Keppler
+ Sascha Knell
+ Thomas Meenken
+ Robin Putzar
+ Udo Ziegenhagel
+ Thomas Zweigle
