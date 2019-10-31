import 'package:hive/hive.dart';

abstract class StorageService {
  Box hiveBox;

  Future<void> startInstance();

  Future<void> closeBoxInstance() async {
    await hiveBox.compact();
    await hiveBox.close();
  }
}
