import 'package:drift/drift.dart';

/// Represents a player profile
class DriftProfile extends Table {
  /// ID provided by DE
  late final id = text()();

  /// in-game username
  late final username = text()();

  /// Player rank
  late final rank = integer()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
