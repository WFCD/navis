import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<bool> checkFile(String path) async =>
    File(await tempDirectory() + path).existsSync();

Future<File> getFile(String path) async => File(await tempDirectory() + path);

Future<File> saveFile(String path, String data) async {
  final file = File(await tempDirectory() + path);

  return file.writeAsString(data);
}

Future<String> tempDirectory() async {
  final directory = await getTemporaryDirectory();

  return directory.path;
}
