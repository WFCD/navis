import 'package:codable/codable.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

abstract class WorldstateObject extends Coding
    with EquatableMixinBase, EquatableMixin {
  String id;
  DateTime activation, expiry;

  @override
  @mustCallSuper
  void decode(KeyedArchive object) {
    super.decode(object);

    id = object.decode('id');
    expiry = DateTime.parse(
        object.decode('expiry') ?? DateTime.now().toIso8601String());

    try {
      activation = DateTime.parse(object.decode('activation'));
    } catch (err) {
      activation = DateTime.now();
    }
  }

  @override
  @mustCallSuper
  void encode(KeyedArchive object) {
    object.encode('id', id);
    object.encode('activation', activation.toIso8601String());
    object.encode('expiry', expiry.toIso8601String());
  }

  @override
  List get props => [id, activation, expiry];
}

mixin CycleModel on WorldstateObject {
  String state;
  bool stateBool;
}
