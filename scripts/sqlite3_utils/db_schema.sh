#!/bin/bash

sqlite3 -batch $1 <<EOF
.schema
EOF
