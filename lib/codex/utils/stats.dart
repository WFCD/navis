import 'dart:math' as math;

double statRoundDouble(num value, int places) {
  final mod = math.pow(10.0, places);

  return (value * mod).roundToDouble() / mod;
}
