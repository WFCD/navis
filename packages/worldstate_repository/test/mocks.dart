import 'package:flutter/widgets.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_settings/user_settings.dart';
import 'package:wfcd_client/wfcd_client.dart';
import 'package:worldstate_repository/worldstate_repository.dart';

class MockUserSettings extends Mock implements UserSettings {
  @override
  GamePlatforms get platform => GamePlatforms.pc;

  @override
  Locale get language => const Locale('en');
}

class MockWorldstateComputeRunners extends Mock
    implements WorldstateComputeRunners {}
