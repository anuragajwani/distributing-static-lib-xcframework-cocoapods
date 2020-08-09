if [ -d "build" ]; then
  rm -rf build
fi

# Build static library for simulators

xcodebuild build \
  -scheme MyStaticLib \
  -derivedDataPath derived_data \
  -arch x86_64 \
  -sdk iphonesimulator \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES
mkdir -p build/simulators
cp -r derived_data/Build/Products/Debug-iphonesimulator/ build/simulators

# Build static library for devices

xcodebuild build \
  -scheme MyStaticLib \
  -derivedDataPath derived_data \
  -arch arm64 \
  -sdk iphoneos \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES
mkdir -p build/devices
cp -r derived_data/Build/Products/Debug-iphoneos/ build/devices

# Create XCFramework for static library build variants

xcodebuild -create-xcframework \
    -library build/simulators/libMyStaticLib.a \
    -library build/devices/libMyStaticLib.a \
    -output build/MyStaticLib.xcframework
