SHELL := /bin/bash
MATLAB_PATH=/ai/opt/matlab14a/bin/matlab -nojvm -nodisplay

paramTest.txt:
	${MATLAB_PATH} < paramTest.m | tee $@

%.eq: %.png
	${MATLAB_PATH} -r "image2eq.m('$<'), quit"

%.tex: %.eq
	python parse.py $<

pdfs/%.pdf: %.tex:
	latex2pdf $< > $@
	#evince $@
