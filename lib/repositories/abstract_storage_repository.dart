import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

@immutable
abstract class StorageRepository {
  const StorageRepository(this.box);

  final Box box;

  Stream<BoxEvent> get watchBox => box.watch();

  Future<void> closeBoxInstance() async {
    // await hiveBox.compact();
    await box.close();
  }
}
