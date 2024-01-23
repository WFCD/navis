import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

T fixture<T>(String name) {
  String fixture;

  try {
    fixture = _file(p.join('test', 'fixtures', name));
  } catch (err) {
    fixture = _file(p.join('fixtures', name));
  }

  return json.decode(fixture) as T;
}

String _file(String path) => File(path).readAsStringSync();
