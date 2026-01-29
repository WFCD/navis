import 'package:drift/drift.dart';
import 'package:warframestat_client/warframestat_client.dart';

class CodexItems extends Table {
  late final uniqueName = text()();
  late final name = text()();
  late final description = text().nullable()();
  late final imageName = text().nullable()();
  late final category = text()();
  late final isVaulted = boolean()();
  late final isMasterable = boolean()();
  late final maxLevel = integer().nullable()();
  late final wikiaUrl = text().nullable()();
  late final wikiaThumbnail = text().nullable()();
  late final type = textEnum<ItemType>()();

  @override
  Set<Column<Object>>? get primaryKey => {uniqueName};
}
