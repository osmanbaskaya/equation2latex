SHELL := /bin/bash
MATLAB_PATH=/ai/opt/matlab14a/bin/matlab -nojvm -nodisplay

paramTest.txt:
	${MATLAB_PATH} < paramTest.m | tee $@
