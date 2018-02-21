#!/bin/bash

sqlite3 -batch $1 <<EOF
.mode csv
.import $3 $2
EOF
