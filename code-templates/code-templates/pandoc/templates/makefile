ABS_PATH=$(abs_path)
TEX_PATH=$(tex_path)
ROOT_PATH=$(root_path)

build.tex:
	pandoc \
		-s \
		--toc \
		--filter=pandoc-crossref \
		--variable=block-headings \
		--variable=numbersections \
		--variable=table-use-row-colors \
		--lua-filter=./minted.lua \
		-M figPrefix="Figure" \
		--citeproc \
		--shift-heading-level=0 \
		--template \
		/home/bernd/code-templates/pandoc/templates/default_mod.latex \
		-H \
		/home/bernd/code-templates/pandoc/templates/preamble.tex \
		--from="markdown" \
		$(ABS_PATH) \
		-t \
		beamer\
		--output=$(TEX_PATH) \
		--verbose
	# -V \
		# classoption:aspectratio=169 \

	# --from="markdown+rebase_relative_paths"
build.pdf:
	# rg --passthru -w "\./" -r "$(ROOT_PATH)/" $(TEX_PATH) > tmp.tex
	rg --passthru -e "\{\./" -r "{$(ROOT_PATH)/" $(TEX_PATH) > tmp.tex
	mv tmp.tex $(TEX_PATH)
	latexmk -xelatex -shell-escape $(TEX_PATH) -output-directory=/tmp/slides
clean:
	latexmk -c -output-directory=$(ROOT_PATH)
	rm -rf _minted*/
copy:
	fd . /tmp/slides/ -e ".pdf" --exec cp {} $(ROOT_PATH)
build:
	make clean
	make build.tex
	make build.pdf
	make copy
