#!/bin/bash

python ./testrunner.py --rootdir ../../../clean/ \
			--ignoredir . \
			--specific_file $1 >& tmp.log

tail tmp.log
