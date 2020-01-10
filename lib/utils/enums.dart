enum Platforms { pc, ps4, xb1, swi }

enum Formats { mm_dd_yy, dd_mm_yy, month_day_year }

enum CodexDatabase { drops, items }

extension CodexDatabaseX on CodexDatabase {
  String toProperString() {
    return toString().split('.').last;
  }

  static CodexDatabase parseString(String string) {
    return CodexDatabase.values.firstWhere(
      (v) => v.toString() == 'CodexDatabase.$string',
      orElse: () => CodexDatabase.drops,
    );
  }
}
