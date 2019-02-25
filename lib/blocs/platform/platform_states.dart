import 'package:equatable/equatable.dart';

abstract class PlatformState extends Equatable {
  String platform;
}

class KDefaultState extends PlatformState {
  // used as the initial state for the start of the app will always
  // emit nothing as the default platform and at the start of the app
  // either the saved platform will be restored or it will default to pc
}

class PlatformRestore extends PlatformState {
  PlatformRestore(this._restored);

  final String _restored;

  @override
  String get platform => _restored;
}

class PCState extends PlatformState {
  @override
  String get platform => 'pc';
}

class PS4State extends PlatformState {
  @override
  String get platform => 'ps4';
}

class Xb1State extends PlatformState {
  @override
  String get platform => 'xb1';
}

class SwitchState extends PlatformState {
  @override
  String get platform => 'swi';
}
