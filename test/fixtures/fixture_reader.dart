import 'dart:io';

import 'package:path/path.dart' as p;

String fixture(String name) {
  try {
    return _file(p.join('test', 'fixtures', name));
  } on FileSystemException catch (e) {
    if (e.osError?.errorCode == 2) {
      return _file(p.join('fixtures', name));
    } else {
      rethrow;
    }
  }
}

String _file(String path) => File(path).readAsStringSync();
