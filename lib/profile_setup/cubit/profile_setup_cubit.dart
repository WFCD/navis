import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:profile_repository/profile_repository.dart';
import 'package:settings_repository/settings_repository.dart';
import 'package:warframe_api/warframe_api.dart';

part 'profile_setup_state.dart';

class ProfileSetupCubit extends Cubit<ProfileSetupState> {
  ProfileSetupCubit(this._settings, [this.maxSteps = 3]) : super(const ProfileSetupState(0));

  final int maxSteps;
  final SettingsRepository _settings;

  void nextStep() {
    if (state.currentStep == 2 && state.isValidData == null) return;
    emit(state.copyWith(currentStep: min(state.currentStep + 1, maxSteps)));
  }

  void previousStep() => emit(state.copyWith(currentStep: max(state.currentStep - 1, 0)));

  void goToStep(int step) => emit(state.copyWith(currentStep: step));

  void validateUserData(String? input) {
    final isValid = ProfileRepository.validateUserData(input ?? '');
    if (!isValid) return;

    _settings.accountId = input!;
    emit(state.copyWith(isValidData: isValid));
    nextStep();
  }

  // TODO(Orn): replace with enum in warframe_common
  void updatePlatform(WarframeSupportedPlatform platform) {
    _settings.platform = platform.index;
    emit(state.copyWith(platform: platform));
    nextStep();
  }
}
