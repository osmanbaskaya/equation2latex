SHELL := /bin/bash
:
:q
#MATLAB_PATH=/ai/opt/matlab14a/bin/matlab -nojvm -nodisplay
#MATLAB_PATH=/home/tyr/Documents/MATLAB/bin/matlab -nojvm -nodisplay
MATLAB_PATH=/Applications/MATLAB_R2013b.app/bin/matlab -nojvm -nodisplay

paramTest.txt:
	${MATLAB_PATH} < paramTest.m | tee $@

outputs/%.eq: equations/%.png
	${MATLAB_PATH} -r "image2eq('$<'), quit" | tail -2 | head -1 > $@
	#cat $@

outputs/%.tex: outputs/%.eq
	cat $< | python eq2tex.py > $@

%.pdf: outputs/%.tex
	cd outputs; pdflatex $*.tex; # evince $@ & 

clean:
	rm -f outputs/*.pdf outputs/*.tex outputs/*.eq outputs/*.log outputs/*.aux

.SECONDARY:
