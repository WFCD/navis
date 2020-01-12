import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

@immutable
abstract class StorageResource {
  const StorageResource(this.box);

  final Box box;

  ValueListenable<Box> watchBox({String key}) => box.listenable();

  Future<void> closeBoxInstance() async {
    // await hiveBox.compact();
    await box.close();
  }
}
