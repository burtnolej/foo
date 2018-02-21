#!/bin/bash

cd /Users/burtnolej/Development/pythonapps/clean

#git add css/recipes/*.css
#git add css/*.css
#git add js/clean/js/lib/*.js
#git add js/clean/js/*.js
#git add js/clean/*.js
#git add js/*.js
#git add phpapps/apps/*.php
#git add phpapps/utils/*.php
git add apps/schoolschedulewizard/*.py
git add apps/schoolschedulewizard/*.sh
git add utils/*.py
git add apps/schoolschedulewizard/*.sh
#git add phpapps/apps/sswebviewer/*.css
#git add phpapps/apps/sswebviewer/*.php
#git add phpapps/apps/sswebviewer/*.xml
#git add js/dev/js/*.js
#git add js/dev/js/lib/*.js
#git add phpapps/apps/sswebviewer/css/*.css

git status

if [ "$1" = "" ]; then 
echo "no checking message provided.quiting";
exit;
fi

if [ "$1" = "test"]; then
exit;
fi

git commit -m "$1"

git push -u origin master
