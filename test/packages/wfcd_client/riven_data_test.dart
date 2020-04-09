import 'dart:io';

import 'package:test/test.dart';
import 'package:wfcd_client/clients.dart';
import 'package:wfcd_client/enums.dart';
import 'package:worldstate_api_model/entities.dart';

void main() {
  final directory = Directory.systemTemp;
  RivenDataClient client;

  Future<void> runCheck(Platforms platform) async {
    final client = RivenDataClient(directory.path, platform: platform);

    await client.downloadRivenData();

    expect(client.rivenData.existsSync(), true);
  }

  group('Test Riven data download per platform', () {
    test('PC download check', () => runCheck(Platforms.pc));

    test('PS4 download check', () => runCheck(Platforms.ps4));

    test('Xbox One download check', () => runCheck(Platforms.xb1));

    test('Nintendo Switch download check', () => runCheck(Platforms.swi));
  });

  group('Test Riven data category retrivers', () {
    client = RivenDataClient(directory.path);

    test('Retrive Archgun rivens', () async {
      final corvas =
          await client.getArchgunRivenData('Veiled Archgun Riven Mod');

      expect(corvas.unrolled.itemType, 'Archgun Riven Mod');
    });

    test('Retrive Kitgun rivens', () async {
      final catchmoon =
          await client.getKitgunRivenData('Veiled Kitgun Riven Mod');

      expect(catchmoon.unrolled.itemType, 'Kitgun Riven Mod');
    });

    test('Retrive Melee rivens', () async {
      final melee = await client.getMeleeRivenData('Veiled Melee Riven Mod');

      expect(melee.unrolled.itemType, 'Melee Riven Mod');
    });

    test('Retrive Pistol Riven', () async {
      final pistol = await client.getPistolRivenData('Veiled Pistol Riven Mod');

      expect(pistol.unrolled.itemType, 'Pistol Riven Mod');
    });

    test('Retrive Rifle rivens', () async {
      final rifle = await client.getRifleRivenData('Veiled Rifle Riven Mod');

      expect(rifle.unrolled.itemType, 'Rifle Riven Mod');
    });

    test('Retrive Shotgun rivens', () async {
      final shotgun =
          await client.getShotgunRivenData('Veiled Shotgun Riven Mod');

      expect(shotgun.unrolled.itemType, 'Shotgun Riven Mod');
    });

    test('Retrive Zaw rivens', () async {
      final zaw = await client.getZawRivenData('Veiled Zaw Riven Mod');

      expect(zaw.unrolled.itemType, 'Zaw Riven Mod');
    });
  });

  test('Decode json data', () async {
    final data = await client.getAllRivens();

    expect(data, const TypeMatcher<Map<RivenType, Map<String, RivenData>>>());
  });
}
