# Cephalon Navis
[![Codemagic build status](https://api.codemagic.io/apps/5c82fa94767952001186ff26/5c82fa94767952001186ff25/status_badge.svg)](https://codemagic.io/apps/5c82fa94767952001186ff26/5c82fa94767952001186ff25/latest_build)

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
- Plains and Vallis maps (currently only PoE has the most available data)
- Links to useful guides for new players to learn how to fish
- supports PC, PS4, Xbox and switch worldstates

### Upcoming Features:
- Notifications
- Flash sales and Darvo deal (These two depends on who actually uses it, so if you use it let me know)


# Build Instructions

To build Navis you must first install Flutter from the link below and follow all the instructions needed to get it running for your desired device* then simple run:

```
flutter packages get
flutter build apk
flutter install
```
Optionally ```flutter build apk --target-platform=android-arm64``` will build for arm64 devices


make sure that you follow all the instructions and everything should run smoothly, unless there's a bug in which case report it so I can take care of it

Some screen shots to show progress of what I have so far, animations is a lot smoother in person.

![gif](assets/demo.gif)

keep in mind that I am an amateur at this, and I am still learning to code.

*Note although the app was built using the flutter engine I have not tested it on IOS due to not owing a IDevice or OSX to test on. Might not even compile properly. And a few of the plugins used in this app are not compatible with IOS

## Getting Started

For help getting started with Flutter, view our online
[documentation](https://flutter.dev/docs).