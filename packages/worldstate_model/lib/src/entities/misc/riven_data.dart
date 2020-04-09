import 'package:equatable/equatable.dart';

import 'riven_roll.dart';

class RivenData extends Equatable {
  const RivenData({this.rerolled, this.unrolled});

  final RivenRoll rerolled;
  final RivenRoll unrolled;

  @override
  List<Object> get props => [unrolled, rerolled];
}
