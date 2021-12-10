import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

T fixture<T>(String name) {
  String _fixture;

  try {
    _fixture = _file(p.join('test', 'fixtures', name));
  } catch (err) {
    _fixture = _file(p.join('fixtures', name));
  }

  return json.decode(_fixture) as T;
}

String _file(String path) => File(path).readAsStringSync();
