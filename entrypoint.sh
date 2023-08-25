#!/bin/bash

upstream="$1"
branches="$2"
token="$3"

git config --global url.https://x-access-token:${token}@github.com/.insteadOf https://github.com/

git clone "https://github.com/${GITHUB_REPOSITORY}.git" repo
cd repo 

git config user.name "${GITHUB_ACTOR}"
git config user.email "${GITHUB_ACTOR}@users.noreply.github.com"
git remote add upstream $upstream

git fetch upstream
git fetch upstream --tags
git remote -v

for branch in $branches
do
	if [ $(git rev-parse --verify $branch 2>/dev/null) ]
	then
		git checkout $branch
	else
		git checkout -b $branch upstream/$branch
	fi
	git merge upstream/$branch -m "merge upstream/$branch into $branch"
done

git push origin --all -u
git push origin --tags
