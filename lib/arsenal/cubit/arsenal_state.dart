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

  List<MasteryProgress> get inProgress {
    return xpInfo.where((i) => i.rank < i.maxRank).toList()
      ..sort((a, b) {
        if (a.rank == 0 && b.rank == 0) return 0;
        if (a.rank == 0) return 1;
        if (b.rank == 0) return -1;

        return a.rank.compareTo(b.rank);
      });
  }

  List<MasteryProgress> get warframes =>
      xpInfo.whereNot((i) => i.item.type.isWeapon).toList();

  List<MasteryProgress> get weapons =>
      xpInfo.where((i) => i.item.type.isWeapon).toList();

  List<MasteryProgress> get primaries =>
      xpInfo.where((i) => i.item.type.isPrimary).toList();

  List<MasteryProgress> get secondary =>
      xpInfo.where((i) => i.item.type.isSecondary).toList();

  List<MasteryProgress> get melee =>
      xpInfo.where((i) => i.item.type.isMelee).toList();

  @override
  List<Object> get props => [xpInfo];
}

final class ArsenalFailure extends ArsenalState {}
