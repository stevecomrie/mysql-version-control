#!/bin/bash

# configure
USER="user"
PASS="password"
DB="database_name"

# change to where the script is stored
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

# make log directories
mkdir -p ./migrations
mkdir -p ./logs

# dump the mysql schema
mysqldump -d -u $USER --password=$PASS --opt $DB --single-transaction --add-drop-table=FALSE | sed 's/ AUTO_INCREMENT=[0-9]*\b//' > ./logs/dbdump-$(date +%Y-%m-%d-%T).sql

# create a diff
NEWDIFF="$(find ./migrations -type f | wc -l)"
if [[ $(find ./logs -type f | wc -l) -gt 1 ]]; then    
    mysqldiff $(ls ./logs/dbdump*|awk '{print $1}'|tail -2 | tr "\\n" " ") > ./migrations/${NEWDIFF}.sql
else
    cp $(ls ./logs/dbdump*|awk '{print $1}'|tail -1) ./migrations/0.sql
fi

# don't bother saving empty files & schema logs that haven't changed
if [ ! -s ./migrations/${NEWDIFF}.sql ]; then
    unlink ./migrations/${NEWDIFF}.sql
    unlink $(ls ./logs/dbdump*|awk '{print $1}'|tail -1)
fi