#!/bin/sh

set -eu

if which az; then
	echo "INFO: Building Web App"
	flutter gen-l10n
	flutter build web --web-renderer=canvaskit --base-href /app/
	pushd build
	tar zcf web.tar.gz web
	echo "INFO: Uploading Web App"
	az storage file upload --account-name academity -s user-uploads --source web.tar.gz
	popd
	echo
	echo "Build and Upload Successful."
	echo "You have to copy the built app from storage to the server:"
	echo
	echo "    az webapp ssh -n academity -g Academity"
	echo
	echo "    cd site"
	echo "    tar zxf /UserUploads/web.tar.gz web"
else
	echo "Make sure that azure-cli is available"
	exit 1
fi
