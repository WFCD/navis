# Cephalon Navis
[![Build Status](https://travis-ci.com/WFCD/navis.svg?branch=master)](https://travis-ci.com/WFCD/navis)
[![Supported by the Warframe Community Developers](https://img.shields.io/badge/Warframe_Comm_Devs-supported-blue.svg?color=2E96EF&logo=data%3Aimage%2Fsvg%2Bxml%3Bbase64%2CPHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyOTgiIGhlaWdodD0iMTczIiB2aWV3Qm94PSIwIDAgMjk4IDE3MyI%2BPHBhdGggZD0iTTE4NSA2N2MxNSA4IDI4IDE2IDMxIDE5czIzIDE4LTcgNjBjMCAwIDM1LTMxIDI2LTc5LTE0LTctNjItMzYtNzAtNDUtNC01LTEwLTEyLTE1LTIyLTUgMTAtOSAxNC0xNSAyMi0xMyAxMy01OCAzOC03MiA0NS05IDQ4IDI2IDc5IDI2IDc5LTMwLTQyLTEwLTU3LTctNjBsMzEtMTkgMzYtMjIgMzYgMjJ6TTU1IDE3M2wtMTctM2MtOC0xOS0yMC00NC0yNC01MC01LTctNy0xMS0xNC0xNWwxOC0yYzE2LTMgMjItNyAzMi0xMyAxIDYgMCA5IDIgMTQtNiA0LTIxIDEwLTI0IDE2IDMgMTQgNSAyNyAyNyA1M3ptMTYtMTFsLTktMi0xNC0yOWEzMCAzMCAwIDAgMC04LThoN2wxMy00IDQgN2MtMyAyLTcgMy04IDZhODYgODYgMCAwIDAgMTUgMzB6bTE3MiAxMWwxNy0zYzgtMTkgMjAtNDQgMjQtNTAgNS03IDctMTEgMTQtMTVsLTE4LTJjLTE2LTMtMjItNy0zMi0xMy0xIDYgMCA5LTIgMTQgNiA0IDIxIDEwIDI0IDE2LTMgMTQtNSAyNy0yNyA1M3ptLTE2LTExbDktMiAxNC0yOWEzMCAzMCAwIDAgMSA4LThoLTdsLTEzLTQtNCA3YzMgMiA3IDMgOCA2YTg2IDg2IDAgMCAxLTE1IDMwem0tNzktNDBsLTYtNmMtMSAzLTMgNi02IDdsNSA1YTUgNSAwIDAgMSAyIDB6bS0xMy0yYTQgNCAwIDAgMSAxLTJsMi0yYTQgNCAwIDAgMSAyLTFsNC0xNy0xNy0xMC04IDcgMTMgOC0yIDctNyAyLTgtMTItOCA4IDEwIDE3em0xMiAxMWE1IDUgMCAwIDAtNC0yIDQgNCAwIDAgMC0zIDFsLTMwIDI3YTUgNSAwIDAgMCAwIDdsNCA0YTYgNiAwIDAgMCA0IDIgNSA1IDAgMCAwIDMtMWwyNy0zMWMyLTIgMS01LTEtN3ptMzkgMjZsLTMwLTI4LTYgNmE1IDUgMCAwIDEgMCAzbDI2IDI5YTEgMSAwIDAgMCAxIDBsNS0yIDItMmMxLTIgMy01IDItNnptNS00NWEyIDIgMCAwIDAtNCAwbC0xIDEtMi00YzEtMy01LTktNS05LTEzLTE0LTIzLTE0LTI3LTEzLTIgMS0yIDEgMCAyIDE0IDIgMTUgMTAgMTMgMTNhNCA0IDAgMCAwLTEgMyAzIDMgMCAwIDAgMSAxbC0yMSAyMmE3IDcgMCAwIDEgNCAyIDggOCAwIDAgMSAyIDNsMjAtMjFhNyA3IDAgMCAwIDEgMSA0IDQgMCAwIDAgNCAwYzEtMSA2IDMgNyA0aC0xYTMgMyAwIDAgMCAwIDQgMiAyIDAgMCAwIDQgMGw2LTZhMyAzIDAgMCAwIDAtM3oiIGZpbGw9IiMyZTk2ZWYiIGZpbGwtcnVsZT0iZXZlbm9kZCIvPjwvc3ZnPg%3D%3D)](https://github.com/WFCD/banner/blob/master/PROJECTS.md)
[![Discord](https://img.shields.io/discord/256087517353213954.svg?logo=discord)](https://discord.gg/jGZxH9f)

<a href='https://play.google.com/store/apps/details?id=com.cephalon.navis&pcampaignid=MKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1'><img alt='Get it on Google Play' src='en_get.svg' width="40%"/></a>


Cephalon Navis is an Android app inspired by [Warframe Hub](https://hub.warframestat.us/). Navis for short uses the [WarframeStat.us API](https://docs.warframestat.us/) to display as much useful and necessary information to help you as you travel the solar system without leaving your game.

### Features:
- Display game news including updates
- Supports displaying multiple events
- information on acolytes
- Cetus and Earth Day/Night cycle
- Orb vallis Warm/Cold cycle
- Ostron and Solaris United bounties with Timer
- Void Fissures
- Nightwaves
- Baro Timer and Inventory
- Display Soties and Invasions
- Links to useful guides for new players to learn how to fish and maps
- Darvo Deals
- supports PC, PS4, Xbox and switch worldstates

### Upcoming Features:
- Notifications (soon)
- Flash sales (This depends on who actually uses it, so if you use it let me know)

# Create Keystore 

On Mac/Linux

```
keytool -genkey -v -keystore ~/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key
```

this also works for Windows Subsystem for Linux.

On Windows

```
keytool -genkey -v -keystore c:/Users/USER_NAME/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key
```

## Refrence the Keystore 

Rename `key.properties.example` to `key.properties` and fill in the information.  
The `key.properties` is already refrenced in `app/build.gradle`.

# Generate Firebase service JSON

Best to let Google teach you this one https://firebase.google.com/docs/flutter/setup#configure_an_android_app


# Build Instructions

To build Navis need to install [Flutter](https://flutter.dev/docs/get-started/install) from the link below and follow all the instructions needed to get it running for your desired device* then simple run:

```
flutter pub get
flutter build apk // this will build a fat apk with arm and arm64 libs
flutter install
```

Optionally `flutter build apk --target-platform=android-arm64` will build for arm64 devices and `flutter build apk --target-platform=android-arm` will build for arm devices


make sure that you follow all the instructions and everything should run smoothly, unless there's a bug in which case report issues [here](https://github.com/WFCD/navis/issues) so that they may be fixed.

*Note although the app was built using the flutter engine I have not tested it on IOS due to not owing a IDevice or OSX to test on. Might not even compile properly. And a few of the plugins used in this app are not compatible with IOS

## Getting Started

For help getting started with Flutter, view our online
[documentation](https://flutter.dev/docs).

### Credits:
- [planetary skyboxes](https://imgur.com/gallery/YktJ8)
