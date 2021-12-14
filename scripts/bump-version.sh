#!/bin/sh
CURRENT_PROJECT_VERSION="$1"  # e.g. 2.75

sed -i '' "s/\([_\s]\)VERSION = [-0-9A-Za-z.]*;$/\1VERSION = $CURRENT_PROJECT_VERSION;/g" jitouch/Jitouch/Jitouch.xcodeproj/project.pbxproj
sed -i '' "s/\([_\s]\)VERSION = [-0-9A-Za-z.]*;$/\1VERSION = $CURRENT_PROJECT_VERSION;/g" prefpane/Jitouch.xcodeproj/project.pbxproj
sed -i '' "s/\"Version [-0-9A-Za-z.]*\"/\"Version $CURRENT_PROJECT_VERSION\"/g" prefpane/Base.lproj/JitouchPref.xib

