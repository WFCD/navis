import 'package:wfcd_client/entities.dart';

extension ItemX on Item {
  bool get isMarketTradable {
    final isPrime = name.contains('Prime');

    return tradable ?? isPrime;
  }
}
