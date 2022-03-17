fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## Android

### android beta

```sh
[bundle exec] fastlane android beta
```

Submit a new Beta Build to Crashlytics Beta

### android deploy

```sh
[bundle exec] fastlane android deploy
```

Deploy a new version to the Google Play

### android sendBuildToGoogleChat

```sh
[bundle exec] fastlane android sendBuildToGoogleChat
```

Send Build Android Version Prod

### android buildAndroidLocal

```sh
[bundle exec] fastlane android buildAndroidLocal
```

Build Android Version Local

### android distribute

```sh
[bundle exec] fastlane android distribute
```

Distribute To Firebase

----


## iOS

### ios buildIOS

```sh
[bundle exec] fastlane ios buildIOS
```

Build app prod ios

### ios testFlightDistribute

```sh
[bundle exec] fastlane ios testFlightDistribute
```

TestFlight prod ios

### ios getProvision

```sh
[bundle exec] fastlane ios getProvision
```

Get provision prod ios

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
