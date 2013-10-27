--- 
layout: post
title: SunFlower 0.14 Released
categories: []

tags: []

status: trash
type: post
published: false
meta: 
  _edit_last: "1"
  _wp_trash_meta_status: publish
  _wp_trash_meta_time: "1381771361"
---
<a href="http://sunflower.preenandprune.com/">SunFlower 0.14</a> has been released with one minor bug fix.  The major change, however, is the website and build process.  Since SunFlower is now free, persuasive copy and graphics are no longer a requirement. So the website was demolished and rebuilt with an extreme minimalist aesthetic.

The most tedious thing in the past when creating a new release was updating the website.  So the process of packaging a release now includes automatically updating the website.

<h2>The Change Log</h2>

The previous change log was maintained as a text file.  After each release it was then manually converted into HTML for the release notes page.  The change log is now an xml file.  The initial idea was to use XSLT to convert this XML into HTML, and that is still something that could be done in the future, but most modern browsers can display XML in a readable format if you add a CSS stylesheet in an XML directive at the top of the file.  This keeps things nice and simple.  The same file you edit is the same file you publish.  Sometimes XML is useful.

<pre lang="xml">
<?xml version="1.0"?>
<?xml-stylesheet href="style/changeLog.css" type="text/css"?>
<changeLog>
 <release>
    <version>0.14</version>
    <fix>Cleanup Core Data fault error.</fix>
 </release>
</changeLog>
</pre>

<h2>The Build-Package-Deploy Button</h2>

The next annoying thing was changing the latest version number on the website and in the application. So I wrote a script to make that much less painful. The script even includes tagging source control.


<pre lang="bash">

#!/bin/bash

MYLOCATION=`pwd`
WEBROOT=/Users/mcormier/Sites/SunFlower
RELEASEROOT=/Development/builds/Release

function main {
  parseParam $*
  checkVersionNumberAvailable 
  checkSourceCommited 
  updateInfoPlist
  buildSunFlower
  createZipFile
  copyChangeLog 
  changeWebsiteVersion 

  # Commit Info.plist and tag branch with version number
  git commit -m $VERSION Info.plist 
  git tag $VERSION
}

function parseParam {
  if [ "$1" = "" ] ; then 
    printUsage
    exit
  fi
  VERSION=$1
}
function checkVersionNumberAvailable {
  git tag | grep $VERSION > /dev/null
  if [ $? -eq 0 ] ; then
    echo "------------------------------------------------------"
    echo "Cannot create release. $VERSION has already been used."
    echo "Use git tag to see versin numbers"
    echo "------------------------------------------------------"
    exit
  fi
}

function printUsage {
  echo "Usage : $0 [versionNumber]"
}

function buildSunFlower {
  # Build SunFlower
  TMPFILE=`mktemp /tmp/SunFLowerBuildLog.XXXX`
  echo "Building project.  See log ${TMPFILE} for full build log."
  xcodebuild -project SunFlower.xcodeproj -alltargets > ${TMPFILE}
  if [ $? -ne 0 ] ; then

    echo "===================================================="
    echo "  Error during compliation! See log file for details"
    echo "===================================================="
    exit
  fi
  echo "SunFlower successfully built"
}


function checkSourceCommited {
  # Get number of total uncommited files
  hasUncommitedFiles=$(git status --porcelain 2>/dev/null| wc -l)
  if [ $hasUncommitedFiles -ne 0 ] ; then
    git status
    echo "------------------------------------------------------------------------"
    echo "FAILURE -- could not create release.  All source code is not checked in."
    echo "------------------------------------------------------------------------"
    exit
  fi
}


# replace version number in Info.plist
function updateInfoPlist {
  echo -n "Old version number in Info.plist "
  defaults read ${MYLOCATION}/Info CFBundleShortVersionString
  defaults write  ${MYLOCATION}/Info CFBundleShortVersionString ${VERSION}

  # Convert the plist back to XML format so the C processor can handle it
  plutil -convert xml1 Info.plist
  echo -n "New version number in Info.plist "
  defaults read ${MYLOCATION}/Info CFBundleShortVersionString
}

function createZipFile {
  # Create ZIP file
  pushd . > /dev/null
  cd ${RELEASEROOT}
  zip -qr SunFlower.zip SunFlower.app
  mv SunFlower.zip ${WEBROOT}
  echo "SunFlower packaged into a zip file."
  popd > /dev/null
}

function copyChangeLog {
  echo "Copying changlog to website" 
  cp changeLog.xml $WEBROOT
}

function changeWebsiteVersion {
  pushd . > /dev/null
  cd ${WEBROOT} 
  cat index.html  | sed s/version>[0-9.]*/version>${VERSION}/ > temp.html
  mv temp.html index.html
  echo "Changed version number on website"
  popd > /dev/null
}

main $*
</pre>

Kode on!
