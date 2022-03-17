echo "========================Build Android $BUILD_FLAVOR_KEY Run======================="

if hash fvm 2>/dev/null; then
  echo "Using fvm flutter version"
  echo "Build number without pass param: $BUILD_NUMBER"
  fvm flutter build apk --flavor "$BUILD_FLAVOR_KEY" --build-number "$BUILD_NUMBER"
else
  echo "Using local flutter version"
  echo "Build number without pass param: $BUILD_NUMBER"
  flutter build apk --flavor "$BUILD_FLAVOR_KEY" --build-number "$BUILD_NUMBER"
fi
echo "========================Build Android Finish======================="
