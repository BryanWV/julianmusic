#!/bin/bash
#Bash script to automate deployment in GitHub Pages
# Remove previous versions in docs folder
rm -r docs/
mkdir docs

# Variables
OUTPUT_DIR="docs" #Folder that GitHub Pages allows deployment
BASE_HREF="Music-portfolio-blazor/"
INDEX_FILE="docs/index.html"

dotnet publish --configuration Release
cp -r bin/Release/net8.0/publish/wwwroot/* docs/

#Update <base> href in index.html

if [ -f $INDEX_FILE ];
then
	echo "index file exists"
	sed -i 's/base href="\/"/base href="julianmusic"/g' docs/index.html
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
git commit -m "Automatic Blazor WASM Deployment to GitHub Pages"
git push -u origin main
