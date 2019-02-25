import 'package:equatable/equatable.dart';

abstract class PlatformEvent extends Equatable {}

class PlatformStart extends PlatformEvent {}

class PCEvent extends PlatformEvent {}

class PS4Event extends PlatformEvent {}

class Xb1Event extends PlatformEvent {}

class SwitchEvent extends PlatformEvent {}
