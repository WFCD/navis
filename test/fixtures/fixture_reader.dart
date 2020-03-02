import 'dart:io';

import 'package:path/path.dart' as p;

String fixture(String name) {
  try {
    return _file(p.join('test', 'fixtures', name));
  } catch (err) {
    return _file(p.join('fixtures', name));
  }
}

String _file(String path) => File(path).readAsStringSync();
