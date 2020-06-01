import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  String format(String locale) {
    final dateFormat = DateFormat.yMMMMd(locale).add_jms();
    return dateFormat.format(this);
  }
}
