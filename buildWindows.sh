#!/bin/bash
# Build the Picto Windows installer (build/installer/*.msi).
# Run from the repository root (in Cygwin): the icons are read from resources/.

set -x
set -e

# In GitHub Actions, load the checked out sources; locally, load from GitHub
if [ -n "$GITHUB_WORKSPACE" ]
then
	REPOSITORY="gitlocal://$GITHUB_WORKSPACE/src"
else
	REPOSITORY="github://Ducasse/Picto:master/src"
fi

wget -O - get.pharo.org/64/140+vm | bash
./pharo Pharo.image save Picto

./pharo Picto.image eval --save "Metacello new
	baseline: 'Nonogram';
	repository: '$REPOSITORY';
	onUpgradeUseLoaded;
	onConflictUseLoaded;
	load: #( 'App' 'Tests' )"

./pharo Picto.image eval "NGApplication generateWindowsPackage"

cd build
cmake -B . -S . && cmake --build .
powershell -File buildWindowsPackage.ps1
