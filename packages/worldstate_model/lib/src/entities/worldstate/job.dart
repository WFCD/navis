import 'package:equatable/equatable.dart';

class Job extends Equatable {
  const Job(
    this._rewardPool, {
    this.type,
    this.enemyLevels,
    this.standingStages,
  });

  final String type;
  final dynamic _rewardPool;
  final List<int> enemyLevels, standingStages;

  List<String> get rewardPool {
    return _rewardPool is String
        ? <String>[]
        : (_rewardPool as List<dynamic>).cast<String>();
  }

  /// Calculates total standing per stage
  int get totalStanding => standingStages.fold(0, (a, b) => a + b);

  @override
  List<Object> get props => [type, rewardPool, enemyLevels, standingStages];
}
