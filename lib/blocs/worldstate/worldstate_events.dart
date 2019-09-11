import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

@immutable
abstract class WorldstateEvent extends Equatable {
  const WorldstateEvent([List<dynamic> props = const <dynamic>[]])
      : super(props);
}

class UpdateEvent extends WorldstateEvent {}
