SHELL := /bin/bash
MATLAB_PATH=/ai/opt/matlab14a/bin/matlab -nojvm -nodisplay

run:
	${MATLAB_PATH} < paramTest.m
