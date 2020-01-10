import 'package:intl/intl.dart';

import 'enums.dart';

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

extension FormatsX on Formats {
  DateFormat toDateformat() {
    switch (this) {
      case Formats.dd_mm_yy:
        return DateFormat('hh:mm:ss dd/MM/yyyy');
        break;
      case Formats.month_day_year:
        return DateFormat.yMMMMd('en_US').add_jms();
      default:
        return DateFormat.jms().add_yMd();
    }
  }
}

extension DateTimeX on DateTime {
  String format(DateFormat format) {
    try {
      return format.format(toLocal());
    } catch (err) {
      return 'Fetching Date';
    }
  }

  String get timestamp {
    final Duration duration = difference(DateTime.now().toUtc()).abs();

    const Duration hour = Duration(hours: 1);
    const Duration day = Duration(hours: 24);

    if (duration < hour) {
      return '${duration.inMinutes.floor()}m';
    } else if (duration >= hour && duration < day) {
      return '${duration.inHours.floor()}h ${(duration.inMinutes % 60).floor()}m';
    } else {
      return '${duration.inDays.floor()}d';
    }
  }
}
