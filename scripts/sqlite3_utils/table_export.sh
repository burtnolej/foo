#!/bin/bash

sqlite3 -batch $1 <<EOF
.headers on
.mode csv
.once $3
SELECT * FROM $2;
EOF
