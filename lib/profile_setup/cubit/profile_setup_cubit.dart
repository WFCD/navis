import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:profile_repository/profile_repository.dart';

part 'profile_setup_state.dart';

class ProfileSetupCubit extends Cubit<ProfileSetupState> {
  ProfileSetupCubit([this.maxSteps = 3]) : super(const ProfileSetupState(0));

  final int maxSteps;

  void nextStep() => emit(state.copyWith(currentStep: min(state.currentStep + 1, maxSteps)));

  void previousStep() => emit(state.copyWith(currentStep: max(state.currentStep - 1, 0)));

  void goToStep(int step) => emit(state.copyWith(currentStep: step));

  void validateUserData(String? input) {
    emit(state.copyWith(isValidData: ProfileRepository.validateUserData(input ?? '')));
  }
}
