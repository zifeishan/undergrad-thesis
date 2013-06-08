all: abs-cont.md
	pandoc abs-cont.md -o abs-cont.tex
	xelatex template
	xelatex template
	rm *.out *.aux *.log 
	# rm rw-fo.tex
	mv template.pdf abs-cont.pdf