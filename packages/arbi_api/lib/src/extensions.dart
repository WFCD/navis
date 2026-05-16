// ignore_for_file: experimental_member_use Its gonna get unmarked I swear

import 'package:warframestat_client/warframestat_client.dart';

extension ArbitrationListExtension on List<Arbitration> {
  Arbitration get current {
    final timestamp = DateTime.timestamp();
    return firstWhere((i) => timestamp.isAfter(i.activation) && timestamp.isBefore(i.expiry));
  }
}
