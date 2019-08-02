import 'dart:io';

import 'package:flutter/services.dart';

Future<void> setupPackageMockMethods() async {
  final directory = await Directory.systemTemp.createTemp();

  const MethodChannel('plugins.flutter.io/shared_preferences')
      .setMockMethodCallHandler((MethodCall methodCall) async {
    if (methodCall.method == 'getAll') {
      return <String, dynamic>{}; // set initial values here if desired
    }
    return null;
  });

  const MethodChannel('plugins.flutter.io/path_provider')
      .setMockMethodCallHandler((MethodCall methodCall) async {
    if (methodCall.method == 'getApplicationDocumentsDirectory' ||
        methodCall.method == 'getTemporaryDirectory') {
      return directory.path;
    }
    return null;
  });

  const MethodChannel('plugins.flutter.io/firebase_messaging')
      .setMockMethodCallHandler((MethodCall methodCall) async {});

  const MethodChannel('plugins.flutter.io/package_info')
      .setMockMethodCallHandler((MethodCall methodCall) async {
    if (methodCall.method == 'getAll') return <String, dynamic>{};
    return null;
  });

  const MethodChannel('plugins.flutter.io/firebase_performance')
      .setMockMethodCallHandler((MethodCall methodCall) async {
    if (methodCall.method == 'FirebasePerformance#newHttpMetric') return null;
    return null;
  });
}
