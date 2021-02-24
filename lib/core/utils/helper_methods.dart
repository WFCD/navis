import 'dart:math' as math;

import 'package:flutter/material.dart';

export 'extensions.dart';

Color healthColor(double health) {
  if (health > 50.0) {
    return Colors.green;
  } else if (health <= 50.0 && health >= 10.0) {
    return Colors.orange[900];
  } else {
    return Colors.red;
  }
}

double roundDouble(double value, int places) {
  final mod = math.pow(10.0, places);

  return (value * mod).roundToDouble() / mod;
}
