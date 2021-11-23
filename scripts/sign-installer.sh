#!/bin/sh
CURRENT_PROJECT_VERSION="2.75"
BUILT_PRODUCTS_DIR="build/Jitouch_${CURRENT_PROJECT_VERSION}"
OBJROOT=build/staging
PRODUCT_BUNDLE_IDENTIFIER="com.jitouch.Jitouch"
signing_cert="Developer ID Installer: Aaron Kollasch (5UQY3B3594)"
rm -rf "$OBJROOT"/*
mkdir -p "$OBJROOT/pkg_staging/"
cp -rp ${BUILT_PRODUCTS_DIR}/Jitouch.prefPane ${OBJROOT}/pkg_staging/Jitouch.prefPane
#codesign --sign "${signing_cert}" --deep ${OBJROOT}/pkg_staging/Jitouch.prefPane
pkgbuild --root ${OBJROOT}/pkg_staging/ --component-plist prefpane/components.plist --identifier ${PRODUCT_BUNDLE_IDENTIFIER} --version ${CURRENT_PROJECT_VERSION} --sign "${signing_cert}" --timestamp "${OBJROOT}/JitouchPrefpane.pkg"  --install-location /Library/PreferencePanes
productbuild --distribution prefpane/distribution.xml --package-path ${OBJROOT} --identifier ${PRODUCT_BUNDLE_IDENTIFIER} --version ${CURRENT_PROJECT_VERSION} --sign "${signing_cert}" --timestamp "${BUILT_PRODUCTS_DIR}/Install-Jitouch.pkg"
#xcrun altool --notarize-app --primary-bundle-id ${PRODUCT_BUNDLE_IDENTIFIER} --username "" --password "@keychain:Developer-xcrun" --asc-provider "5UQY3B3594" --file "${BUILT_PRODUCTS_DIR}/Install-Jitouch.pkg"
#xcrun altool --notarization-info <UUID> --username "" --password "@keychain:Developer-xcrun"
