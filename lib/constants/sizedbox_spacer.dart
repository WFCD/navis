import 'package:flutter/widgets.dart';

// These are SizedBox used as simple spacers, for now these are all the ones
// used throughout the app, if one needs to be added it would be here.
//
// At the time of writing it only seems to be height, if anyone needs to add a
// width it would use the same name scheme but with Width instead of Height.
//
// Note: Try to keep the actual value on even numbers.
class SizedBoxSpacer {
  // SizedBox with only height
  static const spacerHeight2 = SizedBox(height: 2);
  static const spacerHeight4 = SizedBox(height: 4);
  static const spacerHeight6 = SizedBox(height: 6);
  static const spacerHeight8 = SizedBox(height: 8);
  static const spacerHeight12 = SizedBox(height: 12);
  static const spacerHeight14 = SizedBox(height: 14);
  static const spacerHeight16 = SizedBox(height: 16);
  static const spacerHeight20 = SizedBox(height: 20);
  static const spacerHeight24 = SizedBox(height: 24);

  // SizedBox with only width
  static const spacerWidth2 = SizedBox(width: 2);
  static const spacerWidth4 = SizedBox(width: 4);
  static const spacerWidth6 = SizedBox(width: 6);
  static const spacerWidth8 = SizedBox(width: 8);
  static const spacerWidth12 = SizedBox(width: 12);
  static const spacerWidth14 = SizedBox(width: 14);
  static const spacerWidth16 = SizedBox(width: 16);
  static const spacerWidth20 = SizedBox(width: 20);
  static const spacerWidth24 = SizedBox(width: 24);
}
