# Changelog
All notable changes to this project will be documented in this file.

## [2.4.10] - 2021-09-28

### Bug Fixes

- Another possible solution to another cache problem

### Miscellaneous Tasks

- Added langs and changed deployment target to iOS 15
- Added logging for state changes

## [2.4.9] - 2021-09-25

### Bug Fixes

- Small fix for open world timers not refreshing properly

### Refactor

- Reduce the number of SizedBox instances to one file

## [2.4.8] - 2021-09-22

### Bug Fixes

- A possible case where expanded tiles would not open

### Testing

- Add a delay so the future has time to complete before checking

## [2.4.7] - 2021-09-22

### Bug Fixes

- Remove acolyte card since they now appear in steel path
- Skybox link typo
- Prevent clearing from dismissing the keyboard

### Miscellaneous Tasks

- Remove assets that are either no longer in used or have been moved to genesis-assets
- Upgrade libs

### Performance

- Get skyboxes at a lower res, should be fine with the blur effect that's over it
- Code optimization

### Refactor

- Use flatMap instead of switchMap
- Properly nested RefreshIndicator
- Code optimizations to bloc preloads
- Improve buildWhen code for timer page
- Use the proper duration for page switching

### Styling

- Organized imports

## [2.4.6] - 2021-09-08

### Performance

- Updates for SDK changes

### Testing

- Corrected types for Ok

## [2.4.5] - 2021-09-08

### Bug Fixes

- Reduce the number of calls to the API

## [2.4.4] - 2021-09-08

### Bug Fixes

- Searching codex would trigger an API call without waiting for user to finish typing

## [2.4.3] - 2021-09-07

### Miscellaneous Tasks

- Update gradle and kotlin plugins
- Update firebase libs
- Update fastlane
- Update Bug Report template
- Changed the extension to yml
- Corrected some syntax issues
- Add code of conduct link
- Update Feature request template
- Corrected a type in template labels
- Update libs

### Performance

- Remove event guide player completely
- Replace bounty sticky header with expansion tiles

### Refactor

- Remove AnimatedContainer around SyndicateTile
- Migrate to new bloc syntax

## [2.4.2] - 2021-08-11

### Bug Fixes

- Cache still has problems loading on some phones so on error we just load of system temp
- Add a label to show vaulted items

### Miscellaneous Tasks

- Update libs

## [2.4.1] - 2021-08-10

### Bug Fixes

- Add some missing translations, other two still need to be translated but the underlining stuff is there

### Miscellaneous Tasks

- Update README to add instructions for how to add translation strings
- Whoops let someother wip stuff leak

### Performance

- Update warframe market client

### Styling

- Corrected linter errors

## [2.4.0] - 2021-07-31

### Features

- Warframe Market partial intergration (#101)

### Styling

- Clean up imports

## [2.3.31] - 2021-07-30

### Bug Fixes

- Backkey settings not be properly read

## [2.3.30] - 2021-07-29

### Bug Fixes

- Nightwave has ended and has caused problems

### Miscellaneous Tasks

- Shrink skybox resolution

## [2.3.29] - 2021-07-26

### Bug Fixes

- Improve mod entry to show drops along with a slider so users can see stats per rank

## [2.3.28] - 2021-07-24

### Bug Fixes

- Minor improvments to codex entries

## [2.3.27] - 2021-07-22

### Bug Fixes

- Temporarly disabled guide player

### Miscellaneous Tasks

- Update packages
- Show raw error when unknown
- Force Firebase instance off when in debug

## [2.3.26] - 2021-07-21

### Bug Fixes

- Possible fix for caching being corrupted
- Testing a fix for the video player guide in events

## [2.3.25] - 2021-07-21

### Bug Fixes

- Add extra context for sentry reports
- Settings should be a dialog when on devices larger then 6 inches

### Miscellaneous Tasks

- Add semantic-release-sentry-releases
- Add extra plugin in release workflow
- Include more env

### Refactor

- Move some common code into start_app

## [2.3.24] - 2021-07-16

### Bug Fixes

- Platfrom not saving properly

### Miscellaneous Tasks

- More flexible way of rendering entry info
- Update podfile

### Styling

- Remove unused imports and other style fixes

## [2.3.23] - 2021-07-16

### Bug Fixes

- Update platform names (#102)

## [2.3.22] - 2021-07-15

### Bug Fixes

- Remove empty values for new weapons

## [2.3.21] - 2021-07-13

### Bug Fixes

- Small tweak so the tabs don't disappear in light mode

### Styling

- Remove an unused import

## [2.3.20] - 2021-07-13

### Bug Fixes

- Show an error icon when an item hasn't been found

### Miscellaneous Tasks

- Update fastlane

## [2.3.19] - 2021-07-03

### Bug Fixes

- Optimzation of UI for larger screens

### Miscellaneous Tasks

- Add more test
- Test on uploading test coverage to coveralls
- Made a syntax error in test workflow
- Seprated nonshared env variables into their respective jobs
- Tidy up test json

### Refactor

- Abstract usersettings away from the UI

### Styling

- Prefer relative imports
- Clean up solsystem test

### Testing

- Usersettings should check if the default is ThemeMode.system first
- Check that the initial state is SolsystemInitial
- Let video url come up as null so it doesn't throw when it actually is
- Add a few more test for Solsystembloc
- Start on darvo bloc test
- For the time being just comment out the
- Finish setting up darvo deal
- Make sure deal saves into cache

## [2.3.18] - 2021-07-01

### Miscellaneous Tasks

- Specfy wfcd_client ref version instead of syncing with HEAD
- Update youtube_explode

### Performance

- Keep user language from being saved on every rebuild
- Update youtube libs

### Refactor

- Migrated navigation bloc to a cubit
- Gave loggers some more details

## [2.3.17] - 2021-06-15

### Bug Fixes

- Update warframe-item models

## [2.3.16] - 2021-06-13

### Bug Fixes

- Worldstate updates not respecting user language settings

### Miscellaneous Tasks

- Replace GITHUB_TOKEN with GH_TOKEN

### Refactor

- Remove unused imports and var

### Testing

- Update podspec for iOS tests

## [2.3.15] - 2021-06-13

### Bug Fixes

- Allow users to override default language behavior

### Miscellaneous Tasks

- Update deps

### Refactor

- Change how platform subscriptions work on first time app opening

## [2.3.14] - 2021-06-10

### Bug Fixes

- Seperated patchlogs from item overview
- Show a wikia button for mods under the description
- To avoid confusion mods now reflect their max rank

### Miscellaneous Tasks

- Migrate to all stable null-safe package
- Update deps
- Update deps

### Refactor

- Widget clean up

### Styling

- Tidy up code according to the linter

## [2.3.13] - 2021-05-28

### Bug Fixes

- A possible error when launching links from the about dialog
- More video fixes

### Miscellaneous Tasks

- Small deps updates
- Repaired iOS test builds
- Update libs

## [2.3.12] - 2021-05-20

### Bug Fixes

- Add an option to disable analytics
- Tidy up news cards to show more of the image, and removed the "New" badge
- Show darvo's deal even if stock finishes
- Possible workaround to video rate limiting

### Miscellaneous Tasks

- Rename Veil proxima with just veil
- Update gradle and kotlin
- Set the minSdkVersion to 21
- Update deps
- Remove unused asset links
- Corrected some intl sentences
- Prevent spider from removing mod asset names

### Refactor

- Force drawer to use secondary color
- Increased the height of the video player card to avoid Renderflex errors
- Lowered the opacity a bit for a less darken picture

### Styling

- General code cleanup

## [2.3.11] - 2021-05-12

### Bug Fixes

- Add a title for darvo's deals (#93)
- Corrected matomo siteID

### Miscellaneous Tasks

- Update test fixtures

## [2.3.10] - 2021-05-11

### Bug Fixes

- Better indicator for void storms

### Miscellaneous Tasks

- Update deps

## [2.3.9] - 2021-05-04

### Miscellaneous Tasks

- Update fastlane
- Ran another bundle update for android's fastlane version

### Performance

- Code optimizations (#91)

## [2.3.8] - 2021-04-16

### Bug Fixes

- Removed an unnessary code from skyboxes that could cause a problem later on

## [2.3.7] - 2021-04-16

### Bug Fixes

- Rendering error when parsing void storm nodes

### Miscellaneous Tasks

- Lowered sdk constraints to 2.10.0

## [2.3.6] - 2021-03-28

### Bug Fixes

- Czech being the default language instead of english

### Miscellaneous Tasks

- Update worldstate json
- Size BackgroundImages height to widget height

## [2.3.5] - 2021-03-25

### Bug Fixes

- Errors occuring when blueprint doesn't exist in components

## [2.3.4] - 2021-03-22

### Performance

- More worldstate error handling

## [2.3.3] - 2021-03-21

### Bug Fixes

- Updated models for steel path

### Miscellaneous Tasks

- Let app internally subscribe to a lang topic based of current lang
- Update packages that are NNB ready

## [2.3.2] - 2021-03-10

### Bug Fixes

- Return cached version when worldstate is empty

### Miscellaneous Tasks

- Update worldstate fixture and models

## [2.3.1] - 2021-03-07

### Bug Fixes

- Fissures and invasions having infinite list length

### Miscellaneous Tasks

- Update semantic-release action to v2.5.3
- Clean up main entry point
- Add syndicate dual screen title to intl
- Tweaked syndicate dual screen padding and cleaned up code
- Reduce syndicate dual pane animation speed to 250 ms
- Update analysis package

## [2.3.0] - 2021-03-05

### Features

- Add a basic card for steel path

### Miscellaneous Tasks

- Code cleanup and migrations to Flutter 2.0.0
- Migrate from crashlytics to sentry
- Intergrated matomo
- Add dart defines to workflows
- Add a seperate main so reports aren't sent while in debug mode
- Update siteID
- Remove provisional flag
- Bump target to iOS 10
- Remove dart:developer import
- Remove kuva card
- Remove a reference to kuva in the worldstate bloc
- Update fastlane

## [2.2.4] - 2021-03-02

### Bug Fixes

- Ensure initializtion of widget bindings before changing the system ui overlay

## [2.2.3] - 2021-03-02

### Miscellaneous Tasks

- Remove the double call to firebase init

### Performance

- Updated firebase dependencies

## [2.2.2] - 2021-02-26

### Bug Fixes

- Updating would fail if forceUpdate wasn't explicitly set
- Countdowns being stuck at the end without updating properly

### Miscellaneous Tasks

- Switch from using extra_pedantic to using very_good_analysis
- Made some "very good" linter fixes
- Remove local notification package
- Structure cleaning

## [2.2.1] - 2021-02-18

### Miscellaneous Tasks

- Remove NDK deps
- Updte fastlane
- Deps updates

### Performance

- Optimizations to how countdowns are calculated

## [2.2.0] - 2021-01-28

### Bug Fixes

- Remove bounties with no names and an unknown reward pool

### Features

- Add a blur effect on news, skybox, and drawer image

### Miscellaneous Tasks

- Update some packages to their null safe versions

### Performance

- Smoother loading for darvo's deals

## [2.1.4] - 2021-01-15

### Bug Fixes

- Scrolling behavior under timers has been redone a bit

### Miscellaneous Tasks

- We can deploy with stable now

## [2.1.3] - 2021-01-15

### Performance

- Update NDK

## [2.1.2] - 2021-01-14

### Bug Fixes

- Force worldstate update during app resume
- Better filtering of expired fissures and invasions (#83)

### Miscellaneous Tasks

- Run setup-ruby and update fastlane-action
- Temporarily run deploy on master
- Re-enable deploy on release
- Remove intl_translations
- Add a folder to ignore
- Ran pub get

## [2.1.1] - 2021-01-09

### Bug Fixes

- Error caused when an item doesn't have any polarities
- News widget having a light background when using light mode

### Miscellaneous Tasks

- Update fastlane
- Possible solution to android's deploy problem
- Repair worldstate test
- Update chewie
- Update client

## [2.1.0] - 2020-12-30

### Bug Fixes

- A text overflow with long alert rewards
- Worldstate not updating when switching platforms or when countdowns end

### Features

- Add a Hero animation for codex item's image
- More compact news tiles
- Darvo's deal will be slightly more compact especially when there is no image

### Miscellaneous Tasks

- Changes to splash icon so it's not so large
- Updated podfile.lock
- Update kotlin plugin version
- Add more generated files to gitignore
- Update youtube_explode_dart

### Performance

- Remove extra skybox logric

### Refactor

- Remove icon para and add tooltip
- Remove size para
- A slight tweak to RowItems to allow it to stay on one line
- Throw error on deal exception and just return the first deal instead of more filtering
- Optimize imports
- Tweaked the mainaxisalignment for Polarties row to layout closer to the end
- Don't try to load image when there is no ImageName

## [2.0.12] - 2020-12-16

### Bug Fixes

- Unable to scroll vertically under an timer tab

### Refactor

- Replace deprecated args

## [2.0.11] - 2020-12-14

### Bug Fixes

- Drops chance not properly reflected as a percentage

### Miscellaneous Tasks

- Temp run deploy on push to master
- Fastlane script not deploying with proper tag
- Run git fetch after check out to get all tags
- Syntax problems
- Flutter by default goes back to root
- Print versionCode to see if it gets cleaned properly
- Pass all pub args to dart's pub tool
- Try using Dir.chdir
- Run pub global packages not local
- Fastlane has been repaired and no longer need deploy on push
- Clean up versionCode before creating changelog
- Update dependencies

## [2.0.10] - 2020-12-11

### Bug Fixes

- Possible error when rendering certain items

### Miscellaneous Tasks

- Add new string
- Fixed Fastfile scripts to get the proper git tags and generate changelogs
- Updated android screenshots
- Consider performance a patch release

### Refactor

- Remove unused imports

## [2.0.9] - 2020-12-02

### Bug Fixes

- Add a discord link to nav drawer for user support

### Miscellaneous Tasks

- Update app store link to public listing
- Update fastlane
- Auto generate changelogs
- Repair possible problem with fastlane script

### Performance

- Scroll expansionTitle until visible

## [2.0.8] - 2020-12-01

### Bug Fixes

- Unable to launch custom tabs in Android 11

### Miscellaneous Tasks

- Expose fastlane password

### Refactor

- Call helper method launchlink instead of url_launcher

### Styling

- Clean up var that aren't being used

## [2.0.7] - 2020-11-30

### Bug Fixes

- Optimizations for larger screen devices

### Miscellaneous Tasks

- Add MATCH_PASSWORD env var

### Refactor

- Removed unused imports

## [2.0.6] - 2020-11-29

### Bug Fixes

- Status bar icon colors being set to white instead of dart
- Possible case where it loops forever
- Show component's drops if they are available
- Slim down darvo's deal when item isn't found

### Miscellaneous Tasks

- Use git ssh link to pull repo
- Remove a comment
- Add firebase ios env

### Refactor

- Arby title should try to take up as little space as  possibl;e
- Prevent cachemanager from loading derelict asset

## [2.0.5] - 2020-11-28

### Miscellaneous Tasks

- Run flutter clean before building.
- Use an ssh key to pull from cert repo

## [2.0.4] - 2020-11-27

### Bug Fixes

- Text buttons blending in with the background when using light them
- Not properly picking up system language

### Miscellaneous Tasks

- Set service account in env
- Update dartz
- Update kotlin plugin
- Remove a TODO
- Remove Podfile.lock

## [2.0.3] - 2020-11-25

### Bug Fixes

- Splash screen icon was super small
- Notification crash on start due to iOS not supporting background messages

### Miscellaneous Tasks

- Base64 wasn't properly decoding the service account
- Sign with appstore certs
- Update fastlane
- Speed up compilation for firebase
- Updated pubspec deps

### Refactor

- Null check VideoController

## [2.0.2] - 2020-11-25

### Bug Fixes

- New Crowdin updates (#77)

### Miscellaneous Tasks

- Remove pub get step

## [2.0.1] - 2020-11-25

### Bug Fixes

- "shield" being repeated multiple times under PowerSuit stats

### Miscellaneous Tasks

- Properly set secrets

## [2.0.0] - 2020-11-25

### Documentation

- Use shiny new Github actions badge
- Maybe add a link to that badge

### Miscellaneous Tasks

- Migrate to github actions
- Remove need for key.properties
- Remove all ref to key.properties
- Update firebase packages
- Fix ios builds
- Clean up workflow names and steps
- Export pub package path
- Migrate release to cider
- Run cider directly with pub
- Run export in deply script

### Refactor

- Migrate to flutter generated translations

## [2.0.0-beta.1] - 2020-10-23

### Bug Fixes

- Cached deals aren't restored properly

### Features

- Temp display events as dialogs

### Miscellaneous Tasks

- Update gms services
- Remove unused l10n import

### Refactor

- Remove comments

## [1.12.0] - 2020-10-13

### Features

- Update target platform to Android 11

## [1.11.7] - 2020-10-12

### Miscellaneous Tasks

- Add android-30 components

## [1.11.6] - 2020-10-12

### Bug Fixes

- Saving darvo deals to cache would fail for weapons
- Fallback to derelict skybox when news images is unable to load

### Miscellaneous Tasks

- Keep up with whatever the current stable build of flutter is
- No idea what fixed it, removed extra space I guess
- Use xcode 12
- Update target to android-30
- Update firebase deps
- Update wfcd client

## [1.11.5] - 2020-09-22

### Bug Fixes

- Update fastlane

## [1.11.4] - 2020-09-22

### Bug Fixes

- Regenerate podfiles using flutter

### Miscellaneous Tasks

- Update cocoapods to v1.9.3

## [1.11.3] - 2020-09-21

### Bug Fixes

- Use factionKey to detect invasion colors

## [1.11.2] - 2020-09-14

### Bug Fixes

- Updated firebase service

## [1.11.1] - 2020-08-29

### Bug Fixes

- Update fastlane

### Miscellaneous Tasks

- Don't let fastlane update itself

## [1.11.0] - 2020-08-29

### Features

- Add Cambion Cycle timer

### Miscellaneous Tasks

- Add the abilty to use custom cycle names for cycles that share the same cycle

## [1.10.1] - 2020-08-25

### Bug Fixes

- Remove an effect that was still under testing
- Small changes to allow you to see Entrati bounties

### Miscellaneous Tasks

- Update fastlane

## [1.10.0] - 2020-08-16

### Bug Fixes

- Add more padding near the bottom

### Features

- Follow fissure styling for arbitration and sentient outpost

### Refactor

- Remove unused variables

## [1.9.5] - 2020-08-13

### Bug Fixes

- Update fastlane

## [1.9.4] - 2020-08-12

### Bug Fixes

- Add build-tools 29.0.3

## [1.9.3] - 2020-08-12

### Bug Fixes

- Better handling of syndicate colors between event syndicates and syndicates

### Miscellaneous Tasks

- Update to flutter v1.20.1
- Updated deps
- Sync wtih current flutter template

### Refactor

- Clean up code for drawer and skybox card

### Styling

- Prefer_const_constructors

## [1.9.2] - 2020-07-17

### Bug Fixes

- Updated fastlane

## [1.9.1] - 2020-07-17

### Bug Fixes

- Remove route restore on cold start

### Miscellaneous Tasks

- Update fastlane and apple specf pass

### Refactor

- Call Timer on app init, build Hydrated storage  closer to start

## [1.9.0] - 2020-07-12

### Features

- Enable fissure notifications by mission type

### Miscellaneous Tasks

- Remove the need to download the drop table

### Refactor

- Ran svgcleaner on some svg
- Updated bloc deps and syntax

### Styling

- Add missing const key

## [1.8.2] - 2020-06-17

### Bug Fixes

- Replace before_install with install

## [1.8.1] - 2020-06-17

### Bug Fixes

- Default to primaryColor when using translated strings

### Miscellaneous Tasks

- Add external group name
- Try to group common task
- Replace before_install with install
- Don't cache flutter install
- Install dart-sdk seperatly
- Fix dart install
- Export dart binaries

### Styling

- Optimize imports

## [1.8.0] - 2020-06-09

### Bug Fixes

- Drop table still being cached

### Features

- Cleaned up codex entry page

### Miscellaneous Tasks

- Provide changelog text
- Cleaned up travis
- Corrected flutter version number
- Install/cache flutter directory

## [1.7.0] - 2020-06-09

### Features

- Download drop table into app data instead of caching

### Miscellaneous Tasks

- Run flutter clean before building apks
- Add default changelog for deploy
- Upload images and default changelog
- Allow ios distrubution to external testers
- Remove platform check
- Ran Flutter intl upgrade

### Styling

- Run fastlane supply

## [1.6.9] - 2020-06-07

### Bug Fixes

- Fastlane setup_travis is an ios only thing

## [1.6.8] - 2020-06-07

### Bug Fixes

- Drawer image wasn't always take up the whole width
- Properly align text to the center on smaller screens

### Miscellaneous Tasks

- Updated fastlane
- Extend tavis_wait to 30 mins
- Use semantic_release to generate changelog
- Setup Fcm.configure during notification init
- Update deps
- Updated README
- Remove date from versionName
- Remove semantic fastlane plugin
- Remove old travis config
- Use semantic-release to set tag, exluded test from running on tags
- Use generic lang for travis semantic-release
- Fix before_install and install
- Dart-sdk not being added to path from flutter
- Attempt export
- Just use flutter to install global packages
- Correct permission on deploy
- Try to export dart sdk

### Refactor

- Remove extra padding between image and drawer options

## [1.6.7] - 2020-06-05

### Features

- V1.6.7

### Miscellaneous Tasks

- Remove --tree-shake-icons in master
- Set app dist cert
- Fix fastlane rescue so no fail on dupes

## [1.6.6] - 2020-06-05

### Bug Fixes

- Consistent app bar, logo in drawer (#70)

### Features

- Support for IOS (#62)
- Support for IOS (#62)

### Miscellaneous Tasks

- New Crowdin translations (#69)
- Fix test for new path_provider
- Remove tree shake icons
- Setup_travis for fastlane

### Refactor

- Send search bloc errors to crashlytics

## [1.5.13] - 2020-04-01

### Miscellaneous Tasks

- Clean up travis config (#52)

## [1.4.0] - 2019-09-20

### Testing

- Yes finally fixed
- Removed unused imports

## [1.3.3] - 2019-09-07

### Testing

- Disabled a test
- Ignore import

## [1.3.0] - 2019-09-04

### Testing

- TestWidgetsFlutterBinding
- Add mock clients

## [1.2.15] - 2019-07-09

### Testing

- Cleanup

## [1.2.6] - 2019-06-29

### Bug Fixes

- Sortie modifier description

## [1.2.4] - 2019-06-23

### Testing

- Fix bloc test

## [1.2.2] - 2019-06-18

### Bug Fixes

- Drawer item jumping from 'Timer' to user's current position
- Remove green border line in debug mode
- Remove green border line in debug mode

### Miscellaneous Tasks

- General code improvemnts and Android

### Testing

- Add api test

<!-- generated by git-cliff -->
