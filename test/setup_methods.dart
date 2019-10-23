import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

Future<void> mockSetup() async {
  final directory = await Directory.systemTemp.createTemp();

  const MethodChannel('plugins.flutter.io/path_provider')
      .setMockMethodCallHandler((MethodCall methodCall) async {
    if (methodCall.method == 'getApplicationDocumentsDirectory' ||
        methodCall.method == 'getTemporaryDirectory') {
      return directory.path;
    }
    return null;
  });

  BlocSupervisor.delegate = await HydratedBlocDelegate.build();
  Hive.init(directory.path);
}
