import 'package:flutter/widgets.dart';

abstract class FactionIcons {
  static const _kFontFam = 'FactionIcons';

  static const IconData corrupted = IconData(0xe805, fontFamily: _kFontFam);
  static const IconData grineer = IconData(0xe806, fontFamily: _kFontFam);
  static const IconData infested = IconData(0xe807, fontFamily: _kFontFam);
  static const IconData corpus = IconData(0xe808, fontFamily: _kFontFam);
  static const IconData sentient = IconData(0xe809, fontFamily: _kFontFam);
}
