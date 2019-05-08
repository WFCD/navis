import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Platforms { pc, ps4, xb1, swi }

enum Formats { mm_dd_yy, dd_mm_yy, month_day_year }

abstract class StorageState {
  Platforms platform;
  Formats dateFormat;

  bool alerts;
  bool baro;
  bool cold;
  bool day;
  bool darvo;
  bool sorties;
  bool night;
  bool stream;
  bool update;
  bool prime;
  bool warm;

  List<String> acolytes;
  List<String> missions;
}

class AppStart extends StorageState {}

class MainStorageState extends StorageState {
  Future<void> getPreferences() async {
    final instance = await SharedPreferences.getInstance();

    platform = Platforms.values.firstWhere((p) =>
        p.toString() == 'Platforms.${instance.getString('platform') ?? 'pc'}');
    dateFormat = Formats.values.firstWhere((f) =>
        f.toString() ==
        'Formats.${instance.getString('dateformat') ?? 'mm_dd_yy'}');

    alerts = instance.getBool('alerts') ?? false;
    baro = instance.getBool('baro') ?? false;
    darvo = instance.getBool('darvo') ?? false;
    prime = instance.getBool('prime') ?? false;
    sorties = instance.getBool('sorties') ?? false;
    stream = instance.getBool('stream') ?? false;
    update = instance.getBool('update') ?? false;
    day = instance.getBool('day') ?? false;
    night = instance.getBool('night') ?? false;
    warm = instance.getBool('warm') ?? false;
    cold = instance.getBool('cold') ?? false;

    acolytes = instance.getStringList('acolytes') ?? <String>[];
    missions = instance.getStringList('missions') ?? <String>[];
  }

  Future<void> toggleOption(String key, bool value, [String item]) async {
    final instance = await SharedPreferences.getInstance();
    final messaging = FirebaseMessaging();

    switch (key) {
      case 'alerts':
        await instance.setBool('alerts', value);
        break;
      case 'baro':
        await instance.setBool('baro', value);
        break;
      case 'darvo':
        await instance.setBool('darvo', value);
        break;
      case 'sorties':
        await instance.setBool('sorties', value);
        break;
      case 'prime':
        await instance.setBool('prime', value);
        break;
      case 'stream':
        await instance.setBool('stream', value);
        break;
      case 'update':
        await instance.setBool('update', value);
        break;
      case 'day':
        await instance.setBool('day', value);
        break;
      case 'night':
        value
            ? messaging.subscribeToTopic('cetus_night')
            : messaging.unsubscribeFromTopic('cetus_night');
        await instance.setBool('night', value);
        break;
      case 'cold':
        await instance.setBool('cold', value);
        break;
      case 'warm':
        await instance.setBool('warm', value);
        break;
      case 'missions':
        value ? missions.add(item) : missions.remove(item);
        await instance.setStringList('missions', missions);
        break;
      case 'acolytes':
        value ? acolytes.add(item) : acolytes.remove(item);
        await instance.setStringList('acolytes', acolytes);
        break;
    }
  }

  bool getToggle(String key, [String item]) {
    switch (key) {
      case 'alerts':
        return alerts;
      case 'baro':
        return baro;
      case 'darvo':
        return darvo;
      case 'sorties':
        return sorties;
      case 'prime':
        return prime;
      case 'stream':
        return stream;
      case 'day':
        return day;
      case 'night':
        return night;
      case 'warm':
        return warm;
      case 'cold':
        return cold;
      case 'missions':
        return missions.contains(item);
      case 'acolytes':
        return acolytes.contains(item);
      default:
        return update;
    }
  }

  Future<void> saveDateFormat(Formats format) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setString('dateformat', format.toString().split('.').last);
  }

  Future<void> savePlatform(Platforms platform) async {
    final instance = await SharedPreferences.getInstance();

    final plat = platform.toString().split('.').last;
    await instance.setString('platform', plat);
  }
}
