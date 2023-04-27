# Cephalon Navis

[![Test status][test_status_badge]][test_status_link]
[![Dev Builds][build_status_badge]][build_status_link]
[![Supported by the Warframe Community Developers][wfcd_badge]][wfcd_link]
[![Discord][discord_shield]][discord_invite]

[![Google Play Badge][google_play_badge]][google_play_link]

<!-- [![App Store Badge](assets/app-store-badge.svg)](https://apps.apple.com/us/app/cephalon-navis/id1516388397) -->

Cephalon Navis is an Android app inspired by [Warframe Hub](https://hub.warframestat.us/). Navis for short uses the [WarframeStat.us API](https://docs.warframestat.us/) to display as much useful and necessary information to help you as you travel the solar system without leaving your game.

### Features:

- Warframe news
- in-game events
- Darvo daily deal of the day
- Baro Ki'Teer timer and inventory
- Sorties
- Void Fissures and Void storms
- invasions and construction progress
- Open world cycle timers
- Open world syndicate bounties
- Nightwaves
- Notifications (mostly done)

### Credits:

- [planetary skyboxes](https://imgur.com/gallery/YktJ8)

# Android setup

## Create Keystore

On Mac/Linux/WSL

```
keytool -genkey -v -keystore ~/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key
```

On Windows

```
keytool -genkey -v -keystore c:/Users/USER_NAME/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key
```

If you change your keystore alies make sure to to replace KeyAlia, under android/app/build.gradle, with your own custom alias.

## Use Keystore

Once your Keystore has been generated store your keystore.jks under the android folder. Then set an environment variable `TENNO_CIPHER` as the password for your generated keystore.jks

# iOS setup

iOS apps require a certifcate from Apple in order to be signed and installed on a physical device.

# Generate Firebase service JSON

Best to let Google teach you this one https://firebase.google.com/docs/flutter/setup#configure_an_android_app

# Build Instructions

To build Navis need to install [Flutter](https://flutter.dev/docs/get-started/install) from the link below and follow all the instructions needed to get it running for your desired device then simple run:

```
flutter pub get
flutter build apk/ios/ipa
flutter install
```

Pick the one for your specfic device, apk builds a fat apk, ios builds an `.app` for iOS, and ipa builds an archived version used for the app store

Optionally `flutter build apk --target-platform=android-arm64` or `flutter build apk --target-platform=android-arm` will build an apk with just arm64 or arm libs, this is good as fat apks are much larger and include libs for x86, arm64, and arm.

Make sure that you follow all the instructions and everything should run smoothly, unless there's a bug in which case report issues [here](https://github.com/WFCD/navis/issues) so that they may be fixed.

## Working with Translations 🌐

This project relies on [flutter_localizations][flutter_localizations_link] and follows the [official internationalization guide for Flutter][internationalization_link].

### Adding Strings

1. To add a new localizable string, open the `app_en.arb` file at `lib/l10n/arb/app_en.arb`.

```arb
{
  "tapForMoreDetails": "Tap for more details",
  "@tapForMoreDetails": {
    "description": "General description to tell the user that this object takes you to a different page",
    "type": "text",
    "placeholders": {}
  }
}
```

2. Then add a new key/value and description

```arb
{
    "tapForMoreDetails": "Tap for more details",
    "@tapForMoreDetails": {
      "description": "General description to tell the user that this object takes you to a different page",
      "type": "text",
      "placeholders": {}
    }
    "seeDetails": "See details",
    "@seeDetails": {
        "description": "General button to see more details of given object",
        "type": "text",
        "placeholders": {}
    }
}
```

3. Use the new string

```dart
import 'package:navis/l10n/l10n.dart';

@override
Widget build(BuildContext context) {
  final l10n = context.l10n;
  return Text(l10n.helloWorld);
}
```

### Adding Supported Locales

Update the `CFBundleLocalizations` array in the `Info.plist` at `ios/Runner/Info.plist` to include the new locale.

```xml
    ...

    <key>CFBundleLocalizations</key>
	<array>
		<string>en</string>
		<string>es</string>
	</array>

    ...
```

[test_status_badge]: https://github.com/WFCD/navis/workflows/Testing/badge.svg?branch=master
[test_status_link]: https://github.com/WFCD/navis/actions?query=workflow%3ATesting
[build_status_badge]: https://github.com/WFCD/navis/actions/workflows/build_test.yml/badge.svg
[build_status_link]: https://github.com/WFCD/navis/actions/workflows/build_test.yml
[discord_shield]: https://img.shields.io/discord/256087517353213954.svg?logo=discord
[discord_invite]: https://discord.gg/jGZxH9f
[google_play_badge]: assets/google-play-badge.svg
[google_play_link]: https://play.google.com/store/apps/details?id=com.cephalon.navis&pcampaignid=MKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1
[wfcd_link]: https://github.com/WFCD/banner/blob/master/PROJECTS.md
[wfcd_badge]: https://img.shields.io/badge/Warframe_Comm_Devs-supported-blue.svg?color=2E96EF&logo=data%3Aimage%2Fsvg%2Bxml%3Bbase64%2CPHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyOTgiIGhlaWdodD0iMTczIiB2aWV3Qm94PSIwIDAgMjk4IDE3MyI%2BPHBhdGggZD0iTTE4NSA2N2MxNSA4IDI4IDE2IDMxIDE5czIzIDE4LTcgNjBjMCAwIDM1LTMxIDI2LTc5LTE0LTctNjItMzYtNzAtNDUtNC01LTEwLTEyLTE1LTIyLTUgMTAtOSAxNC0xNSAyMi0xMyAxMy01OCAzOC03MiA0NS05IDQ4IDI2IDc5IDI2IDc5LTMwLTQyLTEwLTU3LTctNjBsMzEtMTkgMzYtMjIgMzYgMjJ6TTU1IDE3M2wtMTctM2MtOC0xOS0yMC00NC0yNC01MC01LTctNy0xMS0xNC0xNWwxOC0yYzE2LTMgMjItNyAzMi0xMyAxIDYgMCA5IDIgMTQtNiA0LTIxIDEwLTI0IDE2IDMgMTQgNSAyNyAyNyA1M3ptMTYtMTFsLTktMi0xNC0yOWEzMCAzMCAwIDAgMC04LThoN2wxMy00IDQgN2MtMyAyLTcgMy04IDZhODYgODYgMCAwIDAgMTUgMzB6bTE3MiAxMWwxNy0zYzgtMTkgMjAtNDQgMjQtNTAgNS03IDctMTEgMTQtMTVsLTE4LTJjLTE2LTMtMjItNy0zMi0xMy0xIDYgMCA5LTIgMTQgNiA0IDIxIDEwIDI0IDE2LTMgMTQtNSAyNy0yNyA1M3ptLTE2LTExbDktMiAxNC0yOWEzMCAzMCAwIDAgMSA4LThoLTdsLTEzLTQtNCA3YzMgMiA3IDMgOCA2YTg2IDg2IDAgMCAxLTE1IDMwem0tNzktNDBsLTYtNmMtMSAzLTMgNi02IDdsNSA1YTUgNSAwIDAgMSAyIDB6bS0xMy0yYTQgNCAwIDAgMSAxLTJsMi0yYTQgNCAwIDAgMSAyLTFsNC0xNy0xNy0xMC04IDcgMTMgOC0yIDctNyAyLTgtMTItOCA4IDEwIDE3em0xMiAxMWE1IDUgMCAwIDAtNC0yIDQgNCAwIDAgMC0zIDFsLTMwIDI3YTUgNSAwIDAgMCAwIDdsNCA0YTYgNiAwIDAgMCA0IDIgNSA1IDAgMCAwIDMtMWwyNy0zMWMyLTIgMS01LTEtN3ptMzkgMjZsLTMwLTI4LTYgNmE1IDUgMCAwIDEgMCAzbDI2IDI5YTEgMSAwIDAgMCAxIDBsNS0yIDItMmMxLTIgMy01IDItNnptNS00NWEyIDIgMCAwIDAtNCAwbC0xIDEtMi00YzEtMy01LTktNS05LTEzLTE0LTIzLTE0LTI3LTEzLTIgMS0yIDEgMCAyIDE0IDIgMTUgMTAgMTMgMTNhNCA0IDAgMCAwLTEgMyAzIDMgMCAwIDAgMSAxbC0yMSAyMmE3IDcgMCAwIDEgNCAyIDggOCAwIDAgMSAyIDNsMjAtMjFhNyA3IDAgMCAwIDEgMSA0IDQgMCAwIDAgNCAwYzEtMSA2IDMgNyA0aC0xYTMgMyAwIDAgMCAwIDQgMiAyIDAgMCAwIDQgMGw2LTZhMyAzIDAgMCAwIDAtM3oiIGZpbGw9IiMyZTk2ZWYiIGZpbGwtcnVsZT0iZXZlbm9kZCIvPjwvc3ZnPg%3D%3D
[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html
[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
