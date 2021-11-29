#!/bin/sh
CURRENT_PROJECT_VERSION="$1"  # eg 2.75

sed -i '' "s/VERSION = [0-9.]*;$/VERSION = $CURRENT_PROJECT_VERSION;/g" jitouch/Jitouch/Jitouch.xcodeproj/project.pbxproj
sed -i '' "s/VERSION = [0-9.]*;$/VERSION = $CURRENT_PROJECT_VERSION;/g" prefpane/Jitouch.xcodeproj/project.pbxproj
sed -i '' "s/\"Version [0-9.]*\"/\"Version $CURRENT_PROJECT_VERSION\"/g" prefpane/Base.lproj/JitouchPref.xib

