import 'package:flutter/widgets.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_settings/user_settings.dart';
import 'package:worldstate_repository/worldstate_repository.dart';

class MockUserSettings extends Mock implements UserSettings {
  @override
  Locale get language => const Locale('en');
}

class MockWorldstateComputeRunners extends Mock
    implements WorldstateComputeRunners {}
