# Jitouch

**Jitouch** is a Mac application that expands the set of multi-touch gestures for MacBook, Magic Mouse, and Magic Trackpad. These thoughtfully designed gestures enable users to perform frequent tasks more easily such as changing tabs in web browsers, closing windows, minimizing windows, changing spaces, and a lot more.

For more details, see https://www.jitouch.com/.

## Installation

Download `Install-Jitouch.pkg` from the [releases](https://github.com/aaronkollasch/jitouch/releases/latest) page.
Double-click and follow the instructions to install.

## Troubleshooting

After opening the Jitouch preference pane in System Preferences, a prompt should appear to give Jitouch accessibility permissions. If the prompt doesn't appear, try switching Jitouch off and on in the Jitouch preference pane. 

To add Jitouch manually, drag Jitouch.app from `Library/PreferencePanes/Jitouch.prefPane/Contents/Resources/Jitouch.app` to the list in System Preferences -> Security & Privacy -> Privacy -> Accessibility. Then, force restart Jitouch with `killall Jitouch` in the Terminal.

## How to build from source

1. Open jitouch/Jitouch/Jitouch.xcodeproj in Xcode and build the project. This will create Jitouch.app in the prefpane folder. For the highest performance, set the Build Configuration to Release.
2. Open prefpane/Jitouch.xcodeproj in Xcode and build the project. This will create Jitouch.prefPane.
3. Double-click Jitouch.prefPane to install Jitouch.

## License

Copyright (c) Supasorn Suwajanakorn and Sukolsak Sakshuwong. All rights reserved.  
Modified work copyright (c) Aaron Kollasch. All rights reserved.

Licensed under the [GNU General Public License v3.0](LICENSE).
