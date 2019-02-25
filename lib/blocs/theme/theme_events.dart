import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ThemeEvent extends Equatable {}

class ThemeStart extends ThemeEvent {}

class ThemeChange extends ThemeEvent {
  ThemeChange({@required this.brightness});

  final Brightness brightness;
}

class ThemeCustom extends ThemeEvent {
  ThemeCustom({this.primaryColor, this.accentColor});

  final Color primaryColor;
  final Color accentColor;
}
