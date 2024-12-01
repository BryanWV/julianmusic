#!/bin/bash
#Bash script to automate deployment in GitHub Pages
# Remove previous versions in docs folder
rm -r docs/
mkdir docs

# Variables
OUTPUT_DIR="docs" #Folder that GitHub Pages allows deployment
INDEX_FILE="docs/index.html"
TIMESTAMP =$(date -u +"%Y-%m-%d %T %Z")
dotnet publish --configuration Release
cp -r bin/Release/net8.0/publish/wwwroot/* $OUTPUT_DIR/

#Update <base> href in index.html

if [ -f $INDEX_FILE ];
then
	echo "index file exists"
	sed -i 's/base href="\/"/base href="julianmusic"/g' $INDEX_FILE
	echo "Updated <base href> in $INDEX_FILE"
else
	echo "index.html file not found in $OUTPUT_DIR"
	exit 1
fi

cd docs/
touch 404.html
cp index.html 404.html
touch .nojekyll
cd ..

git add .
git commit -m "Automated Blazor WASM Deployment to GitHub Pages in $TIMESTAMP"
git push -u origin main
