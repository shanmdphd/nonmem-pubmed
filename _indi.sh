Rscript -e "rmarkdown::render('$1')"
Rscript -e "rmarkdown::render('$1', output_format = 'word_document')"
Rscript -e "rmarkdown::render('$1', output_format = 'pdf_document')"


