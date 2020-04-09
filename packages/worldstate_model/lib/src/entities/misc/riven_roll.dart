import 'package:equatable/equatable.dart';

class RivenRoll extends Equatable {
  const RivenRoll({
    this.itemType,
    this.compatibility,
    this.rerolled,
    this.avg,
    this.stddev,
    this.median,
    this.min,
    this.max,
    this.pop,
  });

  final String itemType, compatibility;
  final bool rerolled;
  final double avg, stddev, median;
  final int min, max, pop;

  @override
  List<Object> get props {
    return [
      itemType,
      compatibility,
      rerolled,
      avg,
      stddev,
      median,
      min,
      max,
      pop
    ];
  }
}
