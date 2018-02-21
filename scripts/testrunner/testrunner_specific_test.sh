#!/bin/bash

# --specific_file [file with path relative to rootdir i.e. ../../apps/schoolschedulewizard/test_sswizard_utils.py 
# --specific_test Test_DBInsert_Direct

python ./testrunner.py --rootdir ../../../clean/ \
			--ignoredir . \
			--specific_file $1 \
			--specific_test $2 >& tmp.log

tail tmp.log
