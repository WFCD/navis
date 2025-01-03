// Don't worry about it
// ignore_for_file: inference_failure_on_function_invocation

import 'package:fish_repository/fish_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Load Deimos fishing data', () async {
    final data = await loadFishResources(FishingRegion.deimos);

    expect(data.map((e) => e.name).contains('Amniophysi'), isTrue);
  });

  test('Load Plains of Eidolon data', () async {
    final data = await loadFishResources(FishingRegion.poe);

    expect(data.map((e) => e.name).contains('Charc Eel'), isTrue);
  });

  test('Load Orb Vallis data', () async {
    final data = await loadFishResources(FishingRegion.vallis);

    expect(data.map((e) => e.name).contains('Echowinder'), isTrue);
  });
}
