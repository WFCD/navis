import 'package:drift/drift.dart';
import 'package:navis_codex/src/codex.dart';
import 'package:navis_codex/src/models/warframe_item.dart';
import 'package:warframestat_client/warframestat_client.dart';

extension CodexBuildX on CodexBuild {
  bool get isOutdated => timestamp.difference(DateTime.now()) > const Duration(days: DateTime.daysPerWeek * 2);
}

extension WarframeItemX on WarframeItem {
  CodexItem toCodexItem() {
    return CodexItem(
      uniqueName: uniqueName,
      name: name,
      description: description,
      imageName: imageName,
      category: category,
      isVaulted: vaulted,
      isMasterable: masterable,
      maxLevel: maxLevelCap,
      type: type,
      wikiaUrl: wikiaUrl,
      wikiaThumbnail: wikiaThumbnail,
    );
  }
}

extension CodexItemX on CodexItem {
  CodexItemsCompanion toCompanion() {
    return CodexItemsCompanion(
      uniqueName: Value(uniqueName),
      name: Value(name),
      description: Value.absentIfNull(description),
      imageName: Value(imageName),
      category: Value(category),
      isVaulted: Value(isVaulted),
      isMasterable: Value(isMasterable),
      maxLevel: Value.absentIfNull(maxLevel),
      type: Value(type),
      wikiaUrl: Value.absentIfNull(wikiaUrl),
      wikiaThumbnail: Value.absentIfNull(wikiaThumbnail),
    );
  }
}

final Map<ItemType, int> _mapPriority = {
  // Warframes, weapons and companions
  ItemType.warframes: 0,
  ItemType.melee: 0,
  ItemType.shotgun: 0,
  ItemType.rifle: 0,
  ItemType.pistol: 0,
  ItemType.dualPistols: 0,
  ItemType.amp: 0,
  ItemType.archMelee: 0,
  ItemType.archGun: 0,
  ItemType.throwing: 0,
  ItemType.pets: 0,
  ItemType.sentinels: 0,
  ItemType.archwing: 0,
  ItemType.companionWeapon: 0,

  // Mods and arcanes
  ItemType.necramechMod: 1,
  ItemType.primaryMod: 1,
  ItemType.secondaryMod: 1,
  ItemType.warframeMod: 1,
  ItemType.shotGunMod: 1,
  ItemType.companionMod: 1,
  ItemType.archwingMod: 1,
  ItemType.archMeleeMod: 1,
  ItemType.archGunMod: 1,
  ItemType.stanceMod: 1,
  ItemType.parazonMod: 1,
  ItemType.kDriveMod: 1,
  ItemType.meleeMod: 1,
  ItemType.peculiarMod: 1,
  ItemType.arcanes: 1,

  // Riven mods
  ItemType.companionWeaponRiven: 1,
  ItemType.archGunRiven: 1,
  ItemType.rifleRiven: 1,
  ItemType.pistolRiven: 1,
  ItemType.shotgunRiven: 1,
  ItemType.meleeRiven: 1,
  ItemType.kitgunRiven: 1,
  ItemType.zawRiven: 1,
  ItemType.rivenMod: 1,

  // Gear quests and nodes
  ItemType.gear: 2,
  ItemType.node: 2,
  ItemType.quests: 2,

  // Relics
  ItemType.relics: 3,

  // Resources and components
  ItemType.resources: 4,
  ItemType.fish: 4,
  ItemType.petResource: 4,
  ItemType.kDriveComponent: 4,
  ItemType.zawComponent: 4,
  ItemType.kitGunComponent: 4,

  // Skins, sigils and glyphs
  ItemType.skin: 5,
  ItemType.sigils: 5,
  ItemType.misc: 5,
  ItemType.glyph: 6,
};

extension ListItemX on List<CodexItem> {
  void prioritizeResults() {
    sort((a, b) {
      final aPriority = _mapPriority[a.type] ?? 100;
      final bPriority = _mapPriority[b.type] ?? 100;

      if (aPriority != bPriority) return aPriority.compareTo(bPriority);

      return a.name.compareTo(b.name);
    });
  }
}
