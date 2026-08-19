import 'package:warframe_common/warframe_common.dart';

final _relicParts = RegExp(r'^(.+?)\s*(\d+|IV|III|II|I)(?:\s+(Intact|Exceptional|Flawless|Radiant))?$');

const _tierWeights = {
  'Intact': 0,
  'Exceptional': 1,
  'Flawless': 2,
  'Radiant': 3,
};

// Map to translate Roman numerals into integers
const _romanToNumber = {
  'I': 1,
  'II': 2,
  'III': 3,
  'IV': 4,
};

typedef RelicSet = ({
  String name,
  String? imageName,
  WarframeItem intact,
  WarframeItem? exceptional,
  WarframeItem? flawless,
  WarframeItem? radiant,
});

int sortRelics(Map<String, dynamic> relicA, Map<String, dynamic> relicB) {
  final isVaultedA = relicA['isVaulted'] as bool? ?? false;
  final isVaultedB = relicB['isVaulted'] as bool? ?? false;

  if (isVaultedA != isVaultedB) {
    return isVaultedA ? 1 : -1;
  }

  final nameA = relicA['name'] as String;
  final nameB = relicB['name'] as String;

  final relicPartsA = _relicParts.firstMatch(nameA);
  final relicPartsB = _relicParts.firstMatch(nameB);

  if (relicPartsA == null || relicPartsB == null) return nameA.compareTo(nameB);

  final textA = relicPartsA.group(1)!;
  final textB = relicPartsB.group(1)!;
  final textCompare = textA.compareTo(textB);
  if (textCompare != 0) return textCompare;

  final numStrA = relicPartsA.group(2)!;
  final numStrB = relicPartsB.group(2)!;
  final numA = int.tryParse(numStrA) ?? _romanToNumber[numStrA] ?? 0;
  final numB = int.tryParse(numStrB) ?? _romanToNumber[numStrB] ?? 0;
  final numberCompare = numA.compareTo(numB);
  if (numberCompare != 0) return numberCompare;

  final tierA = relicPartsA.group(3)!;
  final tierB = relicPartsB.group(3)!;

  return (_tierWeights[tierA] ?? 0).compareTo(_tierWeights[tierB] ?? 0);
}

List<RelicSet> groupRelics(List<Map<String, dynamic>> relics) {
  final grouped = <RelicSet>[];
  for (var i = 0; i < relics.length; i++) {
    final relic = relics[i];
    final name = relic['name'] as String;

    // TODO(Orn): fix this in warframe-items
    if (name.contains('Requiem')) relic['isVaulted'] = false;

    if (name.contains('Eterna')) {
      final relicGroup = (
        name: name.replaceFirst('Intact', '').trim(),
        imageName: relic['imageName'] as String?,
        intact: WarframeItem.fromDatabase(relic),
        exceptional: null,
        flawless: null,
        radiant: null,
      );

      grouped.add(relicGroup);
    }

    if (name.contains('Intact')) {
      final relicGroup = (
        name: name.replaceFirst('Intact', '').trim(),
        imageName: relic['imageName'] as String?,
        intact: WarframeItem.fromDatabase(relic),
        exceptional: WarframeItem.fromDatabase(relics[i + 1]),
        flawless: WarframeItem.fromDatabase(relics[i + 2]),
        radiant: WarframeItem.fromDatabase(relics[i + 2]),
      );

      grouped.add(relicGroup);
    }
  }

  return grouped;
}
