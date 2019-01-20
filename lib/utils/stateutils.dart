import 'package:intl/intl.dart';
import 'package:navis/models/export.dart';

class Stateutils {
  final DateFormat format = DateFormat.jms().add_yMd();
  final WorldState worldstate;

  Stateutils({this.worldstate});

  int get invasions => worldstate.invasions.length;

  Duration durationFormater(String time) => _durations(time);

  Duration get bountyTime {
    try {
      String expiry = worldstate.syndicates.first.expiry;
      return DateTime.parse(expiry).difference(DateTime.now());
    } catch (err) {
      return Duration(minutes: 150);
    }
  }

  Duration get cetusCycleTime {
    try {
      Duration currentTime = _durations(worldstate.cetus.expiry);
      return currentTime;
    } catch (err) {
      if (worldstate.cetus.isDay) return Duration(minutes: 100);

      return Duration(minutes: 50);
    }
  }

  Duration get earthCycleTime {
    Duration currentTime = _durations(worldstate.earth.expiry);
    DateTime expiry = DateTime.parse(worldstate.earth.expiry);

    if (DateTime.now().isAfter(expiry)) return Duration(minutes: 240);

    return currentTime;
  }

  /*Duration get vallisCycleTime {
    Duration currentTime = _durations(worldstate.vallis.expiry);
    DateTime expiry = DateTime.parse(worldstate.vallis.expiry);

    if (DateTime.now().isAfter(expiry)) {
      if (worldstate.vallis.isWarm) return Duration(minutes: 20);

      return Duration(minutes: 4);
    }

    return currentTime;
  }*/

  expiration(String expiry) {
    try {
      return format.format(DateTime.parse(expiry));
    } catch (err) {
      return 'Fetching Date';
    }
  }

  _durations(String expiry) {
    Duration converted;

    try {
      converted = DateTime.parse(expiry).difference(DateTime.now());
    } catch (err) {
      converted = Duration(minutes: 0);
    }

    return converted;
  }
}
