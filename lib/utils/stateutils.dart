import 'package:intl/intl.dart';
import 'package:navis/models/export.dart';

class Stateutils {
  Stateutils({this.worldstate});

  final DateFormat format = DateFormat.jms().add_yMd();
  final WorldState worldstate;

  int get invasions => worldstate.invasions.length;

  DateTime get bountyTime => worldstate.syndicates.first.expiry;

  String expiration(DateTime expiry) {
    try {
      return format.format(expiry);
    } catch (err) {
      return 'Fetching Date';
    }
  }
}
