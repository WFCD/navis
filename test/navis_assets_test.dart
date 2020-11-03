import 'dart:io';

import 'package:navis/resources/resources.dart';
import 'package:test/test.dart';

void main() {
  test('navis_assets assets test', () {
    expect(true, File(NavisAssets.appStoreBadge).existsSync());
    expect(true, File(NavisAssets.derelict).existsSync());
    expect(true, File(NavisAssets.eventInfo).existsSync());
    expect(true, File(NavisAssets.googlePlayBadge).existsSync());
    expect(true, File(NavisAssets.skyboxNodes).existsSync());
    expect(true, File(NavisAssets.wfcdBanner).existsSync());
    expect(true, File(NavisAssets.wfcdLogoColor).existsSync());
  });
}
