#!/bin/bash

set -e

export code="$(dirname "$0")"
cd "$code"

inputPath=Input
outputPath=Output
shimPath=Shims
rm -rf Output
mkdir $outputPath

function run
{
	frameworkName=$1
	frameworkPath=$2
	
	cp -R $inputPath/$frameworkName $outputPath/
	
	frameworkNameMoved=${frameworkName}Original
	
	binaryPathLocal=$outputPath/$frameworkName
	binaryPathLocalMoved=$outputPath/$frameworkNameMoved
	
	binaryPathFull=$frameworkPath/$frameworkName.framework/Versions/A/$frameworkName
	binaryPathFullMoved=$frameworkPath/$frameworkName.framework/Versions/A/$frameworkNameMoved
	
	mv $binaryPathLocal $binaryPathLocalMoved
	
	wrapperName=$shimPath/$frameworkName/Main.m

function clangCommon
{
	clang -fmodules -I "$code/Utils" -Wno-unused-getter-return-value -Wno-objc-missing-super-calls $@
}
	
	clangCommon $wrapperName -dynamiclib -o $wrapperName.o -fmodules -Xlinker -reexport_library $binaryPathLocalMoved -install_name $binaryPathFull -compatibility_version 1.0.0 -current_version 1.0.0
	
	install_name_tool -id $binaryPathFullMoved $binaryPathLocalMoved	
	install_name_tool -change $binaryPathFull $binaryPathFullMoved $wrapperName.o	
		
	mv $wrapperName.o $binaryPathLocal
	
	codesign -f -s - $binaryPathLocalMoved
	codesign -f -s - $binaryPathLocal
}

run "SkyLight" "/System/Library/PrivateFrameworks"
run "CoreDisplay" "/System/Library/Frameworks"
run "QuartzCore" "/System/Library/Frameworks"