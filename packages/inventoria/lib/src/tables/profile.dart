import 'package:drift/drift.dart';

/// Represents a player profile
class DriftProfile extends Table {
  /// ID provided by DE
  late final Column<String> id = text()();

  /// in-game username
  late final Column<String> username = text()();

  /// Player rank
  late final Column<int> rank = integer()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
