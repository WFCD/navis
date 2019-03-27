import 'dart:async';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'storage_states.dart';

enum Platforms { pc, ps4, xb1, swi }

enum Formats { mm_dd_yy, dd_mm_yy, month_day_year }

Future<StorageState> restore() async {
  final pref = await SharedPreferences.getInstance();
  final platform = pref.getString('platform');
  final dateformat = pref.getString('dateformat');

  if (platform == null) await pref.setString('platform', 'pc');

  if (dateformat == null)
    await pref.setString(
        'dateformat', Formats.mm_dd_yy.toString().split('.').last);

  final state = MainStorageState()
    ..platform = platform ?? 'pc'
    ..dateFormat = Formats.values.firstWhere(
        (f) => f.toString() == 'Formats.${pref.getString('dateformat')}');

  return state;
}

Future<StorageState> saveDateFormat(
    StorageState currentState, Formats format) async {
  final pref = await SharedPreferences.getInstance();

  await pref.setString('dateformat', format.toString().split('.').last);

  currentState.dateFormat = format;

  return currentState;
}

Future<StorageState> savePlatform(
    StorageState currentState, String platform) async {
  final pref = await SharedPreferences.getInstance();

  await pref.setString('platform', platform);

  currentState.platform = platform;

  return currentState;
}

DateFormat enumToDateformat(Formats format) {
  switch (format) {
    case Formats.dd_mm_yy:
      return DateFormat('hh:mm:ss dd/MM/yyyy');
      break;
    case Formats.month_day_year:
      return DateFormat.yMMMMd('en_US').add_jms();
    default:
      return DateFormat.jms().add_yMd();
  }
}
