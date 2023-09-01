$dvi_previewer = 'start xdvi -watchfile 1.5';
$ps_previewer  = 'start gv --watch';
$pdf_previewer = 'start zathura';

# $pdflatex = "xelatex -synctex=1 -interaction=nonstopmode -shell-escape %O %S";
# $pdflatex = 'pdflatex -synctex=1 -interaction=nonstopmode -shell-escape %O %S';
# $pdf_mode = 1;
# $dvi_mode = 0;
# $postscript_mode = 0;

# $print_type = 'pdf';
# $pdf_mode = 1;
# $bibtex_use = 2;
# push @generated_exts, "cb";
# push @generated_exts, "cb2";
# push @generated_exts, "spl";
# push @generated_exts, "nav";
# push @generated_exts, "snm";
# push @generated_exts, "tdo";
# push @generated_exts, "nmo";
# push @generated_exts, "brf";
# push @generated_exts, "nlg";
# push @generated_exts, "nlo";
# push @generated_exts, "nls";
# push @generated_exts, "synctex.gz";
# push @generated_exts, "tex.latexmain";
# push @generated_exts, "run.xml";
# $latex = 'latex --src-specials %O %S';
# $pdflatex = 'xelatex -file-line-error -synctex=1 -interaction=nonstopmode -shell-escape %S %O';

# If zero, check for a previously running previewer on the same file and update it.  If nonzero, always start a new previewer.
# $new_viewer_always = 0;

# How to make the PDF viewer update its display when the PDF file changes.  See the man page for a description of each method.
# $pdf_update_method = 2;

# When PDF update method 2 is used, the number of the Unix signal to send
# $pdf_update_signal = 'SIGHUP';

# add_cus_dep('nlo', 'nls', 0, 'nlo2nls');
# sub nlo2nls {
#   system("makeindex $_[0].nlo -s nomencl.ist -o $_[0].nls -t $_[0].nlg" );
# }

# vim: ft=perl
