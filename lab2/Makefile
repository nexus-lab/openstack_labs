PAPER=OpenStack_Lab_02.tex
AUX_DIR=.aux

all: # Compile paper
	latexmk -pdflatex -bibtex -auxdir=$(AUX_DIR) $(PAPER)

clean: # Clean output files
	latexmk -c $(PAPER)

watch: # Recompile on updates to the source file
	latexmk -pdflatex -bibtex -pvc -auxdir=$(AUX_DIR) $(PAPER)
