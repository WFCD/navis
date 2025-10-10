/// A Very Good Project created by Very Good CLI.
library;

import 'package:isar_community/isar.dart';

class NavisDatabase {
  NavisDatabase(this.schemas, this.instance);

  final List<CollectionSchema<dynamic>> schemas;
  final Isar instance;

  static Future<NavisDatabase> open(List<CollectionSchema<dynamic>> schemas, {required String directory}) async {
    final instance = await Isar.open(schemas, directory: directory, maxSizeMiB: 1024 * 20, name: 'navis_database');
    return NavisDatabase(schemas, instance);
  }
}
