#=======================================================================
#
# File    : Makefile
# Version : 2022/07/01 v1.6.0
# Info    : LaTeX package to implement the Fraunhofer CI
#
# Copyright (c) 2020-2022 Matthias Boljen
#
#=======================================================================

DATE = $(word 2, $$Date: 2022-03-08 21:12:23 CET (Di, 08 Mär 2022)$$)
YEAR = $(shell $(ECHO) $(DATE) | $(CUT) -d- -f1)

#-----------------------------------------------------------------------

export BASEDIR ?= $(PWD)

#-----------------------------------------------------------------------

ifneq ($(USER),root)
    INSTALLTEXMF ?= $(shell kpsewhich -expand-var='$$HOMETEXMF' | cut -d: -f1)
ifeq ($(INSTALLTEXMF),$$HOMETEXMF)
    INSTALLTEXMF :=
endif
ifeq ($(INSTALLTEXMF),)
    INSTALLTEXMF = $(shell kpsewhich -expand-var='$$TEXMFHOME' | cut -d: -f1)
ifeq ($(INSTALLTEXMF),$$TEXMFHOME)
    INSTALLTEXMF :=
endif
endif
    UPDMAP ?= updmap-user
else
    INSTALLTEXMF ?= $(shell kpsewhich -expand-var='$$TEXMFLOCAL' | cut -d: -f1)
    UPDMAP ?= updmap-sys
endif

ifeq ($(INSTALLTEXMF),)
    INSTALLTEXMF = $(shell kpsewhich -expand-var='$$TEXMFLOCAL' | rev | cut -d: -f1 | rev)
ifeq ($(INSTALLTEXMF),$$TEXMFLOCAL)
    INSTALLTEXMF :=
endif
endif

ifeq ($(INSTALLTEXMF),)
    INSTALLTEXMF = $(shell kpsewhich -expand-var='$$TEXMFMAIN')
ifeq ($(INSTALLTEXMF),$$TEXMFMAIN)
    INSTALLTEXMF :=
endif
endif

#----------------------------------------------------------------------

PACKAGENAME = fraunhofer
PROFILES = \
	AISEC EMB EMFT EMI ENAS FEP FHR FKIE FOKUS HHI           \
	IAF IAIS IAO IAP IAPT IBMT IBP ICT IDMT IEE IEG IEM IESE \
	IFAM IFF IGB IGCV IGD IGP IIS IISB IKS IKTS ILT IME IML  \
	IMM IMS IMW IMWS INT IOF IOSB IPA IPK IPM IPMS IPT IRB   \
	ISC ISE ISI ISIT IST ITEM ITWM IVI IVV IWES IWKS IWM IWS \
	IWU IZFP IZI IZM LBF MEVIS SCAI SIT UMSICHT WKI IOSB-AST

#----------------------------------------------------------------------

DOCDIR    = doc/latex/$(PACKAGENAME)
SRCDIR    = source/latex/$(PACKAGENAME)
TESTDIR   = tex/generic/$(PACKAGENAME)
TEXDIR    = tex/latex/$(PACKAGENAME)
CONFIGDIR = tex/latex/$(PACKAGENAME)/config
KOMADIR   = tex/latex/$(PACKAGENAME)/koma
BEAMERDIR = tex/latex/$(PACKAGENAME)/beamer

#----------------------------------------------------------------------

LATEX       = pdflatex
NONSTOPMODE = -interaction=nonstopmode
BATCHMODE   = -interaction=batchmode
PDFOUTPUT   = \\input

TEXUNPACK   = tex

LATEXCHECKRERUN = \
	-e 'Rerun to get cross-references right' \
	-e 'Rerun to get outlines right' \
	-e 'Package tocbasic Warning: number width'

INKSCAPE := $(shell which inkscape 2>/dev/null)
EPSTOPDF  = epstopdf

SILENT   := @
RM        = rm -f
SRM       = $(SILENT)$(RM)
RMDIR     = rm -rf
SRMDIR    = $(SILENT)$(RMDIR)

INSTALL   = install -m 644
SINSTALL  = $(SILENT)$(INSTALL)
MKDIR     = install -m 755 -d
SMKDIR    = $(SILENT)$(MKDIR)
ECHO      = echo -e
SECHO     = $(SILENT)$(ECHO)

ZIP       = zip -rv
SZIP      = $(SILENT)$(ZIP)
UNZIP     = unzip -q
SUNZIP    = $(SILENT)$(UNZIP)

CD        = cd
GZIP      = gzip -fk
GREP      = grep
AWK       = awk
CKSUM     = md5sum
GIT       = git

ISODATE  := $(shell date +%Y%m%d)
MKTEXLSR := mktexlsr $(INSTALLTEXMF)

#----------------------------------------------------------------------

SOURCEFILES := $(PACKAGENAME).dtx

LOGOFILES := $(addprefix fhgicon, .eps .pdf)

CONFIGFILES := \
	$(PACKAGENAME).cfg \
	$(addprefix $(PACKAGENAME)-, \
	$(addsuffix .cfg, $(shell echo $(PROFILES) | tr A-Z a-z)))

KOMAFILES := \
	$(PACKAGENAME)-scrvars.sty \
	$(PACKAGENAME)-scrartcl.sty \
	$(PACKAGENAME)-scrreprt.sty \
	$(PACKAGENAME)-scrbook.sty \
	$(PACKAGENAME)-scrlttr2.sty

BEAMERFILES := \
	beamertheme$(PACKAGENAME).sty \
	beameroutertheme$(PACKAGENAME).sty \
	beamerinnertheme$(PACKAGENAME).sty \
	beamercolortheme$(PACKAGENAME).sty \
	beamerfonttheme$(PACKAGENAME).sty

DOCFILES := $(PACKAGENAME).pdf

LATEXFILES := $(PACKAGENAME).sty

TESTFILES := \
	$(PACKAGENAME)-article.tex \
	$(PACKAGENAME)-report.tex \
	$(PACKAGENAME)-book.tex \
	$(PACKAGENAME)-letter.tex \
	$(PACKAGENAME)-beamer.tex \
	$(PACKAGENAME)-poster.tex

UNSOURCEFILES := \
	$(PACKAGENAME).ins \
	$(PACKAGENAME).drv \
	$(LATEXFILES) \
	$(TESTFILES) \
	$(CONFIGFILES) \
	$(KOMAFILES) \
	$(BEAMERFILES)

ZIPFILE := $(PACKAGENAME).tds.zip

BACKUPFILE := $(PACKAGENAME)-backup-$(ISODATE).zip

#-----------------------------------------------------------------------

# Load Makefile.cfg if it exists
-include Makefile.cfg

# Patch to handle Inkscape's new command line interface (since v1.0)
ifdef INKSCAPE
    INKSCAPE_ONE := $(shell $(INKSCAPE) --version 2> /dev/null | grep -c 'Inkscape 1.')
else
    $(error INKSCAPE undefined, probably not installed)
endif

#--------------------------------------------------------------------

default: logo unpack

#--------------------------------------------------------------------

## Unpack source file (default)
unpack: $(UNSOURCEFILES)

$(UNSOURCEFILES): $(SOURCEFILES) Makefile
	$(SECHO) '\n### UNSOURCE $<  ...\n'
	$(TEXUNPACK) $<

#--------------------------------------------------------------------

## Build documentation files
doc: $(LOGOFILES) $(DOCFILES)

define runlatex
	echo '\n### LATEX $(basename $1) ...\n' && \
	$(LATEX) $1 && \
	while $(GREP) -q $(LATEXCHECKRERUN) $(basename $1).log; \
	do \
		echo '\n### LATEX $(basename $1) ...\n'; \
		$(LATEX) $1; \
	done
endef

fraunhofer.pdf: fraunhofer.drv
	$(call runlatex,$<)

#--------------------------------------------------------------------

logo: $(LOGOFILES)

fhgicon.pdf: fhgicon.eps
	$(SECHO) '\n### CREATE $@  ...\n'
	$(EPSTOPDF) $<

fhgicon.eps: fhgicon.svg
	$(SECHO) '\n### CREATE $@  ...\n'
ifeq ($(INKSCAPE_ONE),0)
	$(INKSCAPE) -D --export-eps=$@ $<
else
	$(INKSCAPE) -D --export-type=eps $<
endif

#--------------------------------------------------------------------

DISTFILES = \
	$(SOURCEFILES) \
	$(LOGOFILES) \
	$(LATEXFILES) \
	$(DOCFILES) \
	$(TESTFILES) \
	$(CONFIGFILES) \
	$(KOMAFILES) \
	$(BEAMERFILES)

#--------------------------------------------------------------------

define create_tds
	$(SMKDIR) $(addprefix $(1)/, \
		$(DOCDIR) \
		$(SRCDIR) \
		$(TEXDIR) \
		$(CONFIGDIR) \
		$(TESTDIR) \
		$(KOMADIR) \
		$(BEAMERDIR))
	$(SINSTALL) $(DOCFILES)    $(1)/$(DOCDIR)
	$(SINSTALL) $(SOURCEFILES) $(1)/$(SRCDIR)
	$(SINSTALL) $(LATEXFILES)  $(LOGOFILES) $(1)/$(TEXDIR)
	$(SINSTALL) $(CONFIGFILES) $(1)/$(CONFIGDIR)
	$(SINSTALL) $(KOMAFILES)   $(1)/$(KOMADIR)
	$(SINSTALL) $(BEAMERFILES) $(1)/$(BEAMERDIR)
	$(SINSTALL) $(TESTFILES)   $(1)/$(TESTDIR)
endef

## Install extracted files to TEXMF
install: $(ZIPFILE)
	$(SECHO) '\n### INSTALL ...\n'
	$(SILENT)$(UNZIP) -o $(ZIPFILE) -d $(INSTALLTEXMF)
	$(MKTEXLSR)

## Remove installed files from TEXMF
uninstall:
	$(SECHO) '\n### UNINSTALL ...\n'
	$(SRMDIR) $(addprefix $(INSTALLTEXMF)/, \
			$(DOCDIR) \
			$(SRCDIR) \
			$(TEXDIR) \
			$(TESTDIR) \
			$(CONFIGDIR) \
			$(KOMADIR) \
			$(BEAMERDIR))
	$(MKTEXLSR)

## Update existing installation
reinstall:
	$(SILENT)$(MAKE) uninstall
	$(SILENT)$(MAKE) install

#--------------------------------------------------------------------

## Run tests
test: unpack logo $(subst .tex,.pdf,$(TESTFILES))

$(subst .tex,.pdf,$(TESTFILES)): %.pdf: %.tex
	$(call runlatex,$<)

#--------------------------------------------------------------------

## Make ZIP file for distribution
dist: $(ZIPFILE)

$(ZIPFILE): $(DISTFILES)
	$(eval TMPDIR := $(shell mktemp -d))
	$(call create_tds, $(TMPDIR))
	$(SECHO) '\n### DIST ...\n'
	$(SRM) $(ZIPFILE)
	$(SILENT)($(CD) $(TMPDIR); $(ZIP) $(BASEDIR)/$(ZIPFILE) .)
	$(SRMDIR) $(TMPDIR)

#--------------------------------------------------------------------

## Create backup file
backup: $(BACKUPFILE)

$(BACKUPFILE): $(shell $(GIT) ls-files)
	$(SECHO) '\n### BACKUP ...\n'
	$(SRM) $(BACKUPFILE)
	$(ZIP) $(BACKUPFILE) $^

#--------------------------------------------------------------------

## Clean working directory
clean: docclean testclean
	$(SECHO) '\n### CLEAN ...\n'
	$(RM) $(UNSOURCEFILES)
	$(RM) $(addprefix $(PACKAGENAME), .log)

docclean: distclean
	$(SECHO) '\n### DOCCLEAN ...\n'
	$(RM) $(LOGOFILES)
	$(RM) $(addprefix $(PACKAGENAME), .aux .hd .nav .out .snm .toc)
	$(RM) $(DOCFILES)

distclean:
	$(SECHO) '\n### DISTCLEAN ...\n'
	$(RM) $(ZIPFILE)

testclean:
	$(RM) $(foreach ext, .aux .toc .log .out .pdf .snm .nav, \
		$(addsuffix $(ext), $(basename $(TESTFILES))))

#--------------------------------------------------------------------

## Show variables
vars:
	$(SECHO) 'INSTALLTEXMF = $(INSTALLTEXMF)'
	$(SECHO) 'UPDMAP       = $(UPDMAP)'

#--------------------------------------------------------------------

## This help screen
help:
	$(SECHO) '\nUsage:\n  make <target>\n\nTargets:'
	$(SILENT)$(AWK) '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "  %-15s %s\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)

.PHONY: clean docclean distclean testclean help vars
