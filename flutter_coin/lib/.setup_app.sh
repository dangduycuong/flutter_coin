echo "========================Setup App Before Run======================="
if hash fvm 2>/dev/null; then
  echo "Using fvm flutter version"
  fvm flutter doctor -v
  fvm flutter clean
  fvm flutter pub get
  dart pub global activate flutter_gen
  fvm flutter packages pub run build_runner build --delete-conflicting-outputs
else
  echo "Using local flutter version"
  flutter doctor -v
  flutter clean
  flutter pub get
  dart pub global activate flutter_gen
  flutter packages pub run build_runner build --delete-conflicting-outputs
fi
echo "========================Setup App Finish======================="
