#!/bin/bash

GITHUB_URL=$1
git clone $GITHUB_URL
NAME=$(echo $GITHUB_URL | awk -F/ '{print $5}')

cd $NAME
COMMIT=$(git log --before="$2" | sed -n 1p | awk -F'[ ]' '{print $2}')
echo "Commit is $COMMIT"

git checkout $COMMIT
heroku git:remote -a d2d190fef0af85c80c971
git push heroku master -f
heroku rake db:migrate
firefox https://d2d190fef0af85c80c971.herokuapp.com/
cd ..
rm $NAME -rf