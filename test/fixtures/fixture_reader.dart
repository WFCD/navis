import 'dart:io';
import 'package:path/path.dart' as p;

String fixture(String name) {
  final path = p.join(Directory.current.path, 'fixtures', name);

  return File(path).readAsStringSync();
}
