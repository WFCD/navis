part of 'profile_setup_cubit.dart';

class ProfileSetupState extends Equatable {
  const ProfileSetupState(this.currentStep, {this.isValidData});

  final int currentStep;
  final bool? isValidData;

  ProfileSetupState copyWith({int? currentStep, bool? isValidData}) {
    return ProfileSetupState(currentStep ?? this.currentStep, isValidData: isValidData ?? this.isValidData);
  }

  @override
  List<Object?> get props => [currentStep, isValidData];
}
