import 'package:codable/codable.dart';
import 'package:flutter/widgets.dart';

abstract class WorldstateObject extends Coding {
  String id;
  DateTime activation, expiry;

  @override
  @mustCallSuper
  void decode(KeyedArchive object) {
    super.decode(object);

    id = object.decode('id');
    //activation = DateTime.parse(object.decode('activation'));
    expiry = DateTime.parse(object.decode('expiry'));
  }

  @override
  @mustCallSuper
  void encode(KeyedArchive object) {
    object.encode('id', id);
    object.encode('activation', activation.toIso8601String());
    object.encode('expiry', expiry.toIso8601String());
  }
}

mixin CycleModel on WorldstateObject {
  String state;
  bool stateBool;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);
    state = object.decode('state');
  }

  @override
  void encode(KeyedArchive object) {
    super.encode(object);
    object.encode('state', state);
  }
}
