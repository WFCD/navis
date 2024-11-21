import 'package:flutter/widgets.dart';

// These are SizedBox used as simple spacers, for now these are all the ones
// used throughout the app, if one needs to be added it would be here.
//
// Note: Try to keep the actual value on even numbers.
abstract class Gaps {
  static const gap2 = SizedBox(height: 2);
  static const gap4 = SizedBox(height: 4);
  static const gap6 = SizedBox(height: 6);
  static const gap8 = SizedBox(height: 8);
  static const gap12 = SizedBox(height: 12);
  static const gap14 = SizedBox(height: 14);
  static const gap16 = SizedBox(height: 16);
  static const gap20 = SizedBox(height: 20);
  static const gap24 = SizedBox(height: 24);
}
