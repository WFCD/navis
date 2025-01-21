part of 'arsenal_cubit.dart';

sealed class ArsenalState extends Equatable {
  const ArsenalState();

  @override
  List<Object> get props => [];
}

final class ArsenalInitial extends ArsenalState {}

final class ArsenalUpdating extends ArsenalState {}

final class ArsenalSuccess extends ArsenalState {
  const ArsenalSuccess(this.xpInfo);

  final List<MasteryProgress> xpInfo;

  List<MasteryProgress> get warframes =>
      xpInfo.where((i) => i.item.type == ItemType.warframes).toList();

  List<MasteryProgress> get weapons =>
      xpInfo.where((i) => i.item.type.isWeapon).toList();

  List<MasteryProgress> get primaries =>
      xpInfo.where((i) => i.item.type.isPrimary).toList();

  List<MasteryProgress> get secondary =>
      xpInfo.where((i) => i.item.type.isSecondary).toList();

  List<MasteryProgress> get melee =>
      xpInfo.where((i) => i.item.type.isMelee).toList();

  List<MasteryProgress> get companions {
    return xpInfo
        .where(
          (i) => switch (i.item.type) {
            ItemType.sentinels || ItemType.pets => true,
            _ => false
          },
        )
        .toList();
  }

  List<MasteryProgress> get kDrives =>
      xpInfo.where((i) => i.item.type == ItemType.kDriveComponent).toList();

  List<MasteryProgress> get archwing =>
      xpInfo.where((i) => i.item.type == ItemType.archwing).toList();

  List<MasteryProgress> get archGun =>
      xpInfo.where((i) => i.item.type == ItemType.archGun).toList();

  List<MasteryProgress> get archMelee =>
      xpInfo.where((i) => i.item.type == ItemType.archMelee).toList();

  @override
  List<Object> get props => [xpInfo];
}

final class ArsenalFailure extends ArsenalState {}
