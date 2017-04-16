#!/bin/bash
# Put @ the root of the (bb) drive (e.g. /root/udisk/).

git_repo="https://github.com/hak5/bashbunny-payloads.git"
git_branch="master"

export GIT_SSL_NO_VERIFY=1

if [ -d ".git" ]; then
	git pull origin "$git_branch"
else
	git init
	git remote add origin "$git_repo"
	echo "payloads" >> .git/info/sparse-checkout
	echo "docs" >> .git/info/sparse-checkout
	echo "languages" >> .git/info/sparse-checkout
	git pull origin "$git_branch"

	for file in $(ls -A); do
		[[ "${file}" =~ [^payloads$] ]] && { echo "${file}" >> .gitignore; }
	done
	echo "payloads/switch*" >> .gitignore
fi
