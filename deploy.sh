#!/bin/sh

set -eux

if [ "$(basename "$(pwd)")" = 'api_and_admin_portal' ]; then
	cd ..
fi

git subtree split --prefix=api_and_admin_portal --branch=server-deploy HEAD
git push azure server-deploy:master
