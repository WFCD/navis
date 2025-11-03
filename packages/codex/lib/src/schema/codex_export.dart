import 'package:isar_community/isar.dart';

part 'codex_export.g.dart';

@Collection(ignore: {'isOutdated'})
class CodexExport {
  Id id = 1;

  late String hash;

  // https://isar-community.dev/v3/schema.html#datetime
  late DateTime timestamp;

  bool get isOutdated => timestamp.difference(DateTime.now()) > const Duration(days: DateTime.daysPerWeek * 2);
}
