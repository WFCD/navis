import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

@immutable
abstract class WorldstateEvent extends Equatable {
  const WorldstateEvent();

  @override
  List<Object> get props => const [];
}

class UpdateEvent extends WorldstateEvent {}
