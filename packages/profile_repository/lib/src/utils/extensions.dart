import 'package:profile_repository/src/utils/masterable_item.dart';
import 'package:warframe_common/warframe_common.dart';

extension MasterableItemExtension on List<MasterableItem> {
  List<MasterableItem> get warframes => where((i) => i.item.type == ItemType.warframes).toList();

  List<MasterableItem> get weapons => where((i) => i.item.type.isWeapon).toList();

  List<MasterableItem> get primaries => where((i) => i.item.type.isPrimary).toList();

  List<MasterableItem> get secondary => where((i) => i.item.type.isSecondary).toList();

  List<MasterableItem> get melee => where((i) => i.item.type.isMelee).toList();

  List<MasterableItem> get kDrives => where((i) => i.item.type == ItemType.kDriveComponent).toList();

  List<MasterableItem> get archwing => where((i) => i.item.type == ItemType.archwing).toList();

  List<MasterableItem> get archGun => where((i) => i.item.type == ItemType.archGun).toList();

  List<MasterableItem> get archMelee => where((i) => i.item.type == ItemType.archMelee).toList();

  List<MasterableItem> get inProgress =>
      where((i) => i.level < (i.item.maxLevel ?? 30) && i.xp != 0).toList()..sort((a, b) => (b.xp).compareTo(a.xp));

  List<MasterableItem> get companions {
    return where(
      (i) => switch (i.item.type) {
        ItemType.sentinels || ItemType.pets => true,
        _ => false,
      },
    ).toList();
  }

  Iterable<MasterableItem> filterByCategory(ItemType type) => where((e) => e.item.type == type);
}
