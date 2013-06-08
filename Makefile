# vim:ts=4:sw=4
#
# Copyright (c) 2008-2009 solvethis
# Copyright (c) 2010-2012 Casper Ti. Vector
# Public domain.

# 被编译的主文件的文件名，不包括扩展名。
JOBNAME = zifei-thesis
# 这个变量的值可以为 latex、pdflatex 或 xelatex。
# LATEX = latex
LATEX = xelatex
# 如果无法使用 biber，可以改为“bibtex”。
BIBTEX = biber -l zh__pinyin
# BIBTEX = bibtex -l zh__pinyin
GBK2UNI = gbk2uni
DVIPDF = dvipdfmx

# 如果用 LaTeX 编译，则使用 dvipdfmx 将 dvi 转成 pdf。
ifeq ($(LATEX), latex)
	DODVIPDF = $(DVIPDF) $(JOBNAME)
endif

# 使用 GBK 编码和 pdflatex 编译方式时，可能需要使用 gbk2uni 转换 .out
# 文件编码，以防书签乱码。
ifeq ($(LATEX), pdflatex)
	# 考虑到可能有用户未安装 gbk2uni，且有用户使用 UTF-8 编码，
	# 默认用“#”注释掉了 DOGBK2UNI 的定义。
	# 用户可以手动取消其注释（去掉下一行中的“#”）。
	#DOGBK2UNI = $(GBK2UNI) $(JOBNAME)
endif

# 区分是 Windows 环境还是类 UNIX 环境。
# 如果是后者，则 GNU make 将可以检测到已经定义 PATH 环境变量。
ifdef PATH
	MAKE = make
	RM = rm -f
else
	MAKE = mingw32-make
	RM = del
endif

all: tex img doc clean

print: all
	pdftk advisor.pdf zifei-thesis.pdf output zifei-thesis-print.pdf

pre: template/$(JOBNAME).tex tex
	$(LATEX) template/$(JOBNAME)

tex: abstract intro related algo applic eval anal visual future conclusion acknowledge
# technical evaluation related conclusion appendix

visual: md/visual.md
	pandoc md/visual.md -o tex/visual.tex

acknowledge: md/acknowledge.md
	pandoc md/acknowledge.md -o tex/acknowledge.tex
applic: md/application.md
	pandoc md/application.md -o tex/application.tex
abstract: md/abstract.md
	pandoc md/abstract.md -o tex/abstract.tex

intro: md/intro.md
	pandoc md/intro.md -o tex/intro.tex

related: md/related.md
	pandoc md/related.md -o tex/related.tex

algo: md/algo.md
	# cp md/algo.tex tex/algo.tex
	pandoc md/algo.md -o tex/algo.tex	

eval: md/eval.md
	pandoc md/eval.md -o tex/eval.tex

anal: md/anal.md
	pandoc md/anal.md -o tex/anal.tex

future: md/future.md
	pandoc md/future.md -o tex/future.tex
	
conclusion: md/conclusion.md
	pandoc md/conclusion.md -o tex/conc.tex

img:
	cd img && $(MAKE)

img-clean:
	cd img && $(MAKE) clean

doc: template/$(JOBNAME).tex $(JOBNAME).bib tex
	$(LATEX) template/$(JOBNAME)
	$(BIBTEX) $(JOBNAME)
	$(DOGBK2UNI)
	$(LATEX) template/$(JOBNAME)
	$(LATEX) template/$(JOBNAME)
	$(DODVIPDF)

clean:
	$(RM) $(JOBNAME).{aux,bbl,bcf,blg,dvi,lof,log,lot,run.xml,toc,out{,.bak}} \
		{missfont,texput}.log chap/*.aux

distclean: clean img-clean
	$(RM) $(JOBNAME).pdf

