import 'package:intl/intl.dart';
import 'package:navis/models/export.dart';

class Stateutils {
  final DateFormat format = DateFormat.jms().add_yMd();
  final WorldState worldstate;

  Stateutils({this.worldstate});

  int get invasions => worldstate.invasions.length;

  DateTime get bountyTime => worldstate.syndicates.first.expiry;

  expiration(DateTime expiry) {
    try {
      return format.format(expiry);
    } catch (err) {
      return 'Fetching Date';
    }
  }
}
