PAPER=OpenStack_Lab_08.tex
AUX_DIR=.aux

all: # Compile paper
	latexmk -pdflatex -auxdir=$(AUX_DIR) $(PAPER)

clean: # Clean output files
	latexmk -c $(PAPER)

watch: # Recompile on updates to the source file
	latexmk -pdflatex -pvc -auxdir=$(AUX_DIR) $(PAPER)