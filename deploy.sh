#!/bin/bash
#Bash script to automate deployment in GitHub Pages
# Remove previous versions in docs folder
rm -r docs/
mkdir docs

# Variables
OUTPUT_DIR="docs" #Folder that GitHub Pages allows deployment
INDEX_FILE="docs/index.html"
TIMESTAMP=$(date -u +"%Y-%m-%d %T %Z")

dotnet publish --configuration Release
cp -r bin/Release/net8.0/publish/wwwroot/* $OUTPUT_DIR/

#Updating <base> href in index.html

if [ -f $INDEX_FILE ];
then
	echo -e "\e[34mIndex file exists\e[0m"
	sed -i 's/base href="\/"/base href="julianmusic"/g' $INDEX_FILE
	echo -e "\e[32mUpdated <base href> in $INDEX_FILE\e[0m"
else
	echo "\e[31mindex.html file not found in $OUTPUT_DIR\e[0m"
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
