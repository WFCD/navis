import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

T fixture<T>(String name) {
  String fixture;

  try {
    fixture = _file(p.join('test', 'fixtures', name));
  } on FileSystemException catch (e) {
    if (e.osError?.errorCode == 2) {
      fixture = _file(p.join('fixtures', name));
    } else {
      rethrow;
    }
  }

  return json.decode(fixture) as T;
}

String _file(String path) => File(path).readAsStringSync();
