import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

abstract class StorageService {
  Box hiveBox;

  @mustCallSuper
  Future<void> startInstance() async {
    WidgetsFlutterBinding.ensureInitialized();
  }

  Future<void> closeBoxInstance() async {
    await hiveBox.compact();
    await hiveBox.close();
  }
}
