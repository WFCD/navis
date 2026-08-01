part of 'profile_setup_cubit.dart';

class ProfileSetupState extends Equatable {
  const ProfileSetupState(this.currentStep, {this.platform, this.isValidData});

  final int currentStep;
  final WarframeSupportedPlatform? platform;
  final bool? isValidData;

  ProfileSetupState copyWith({int? currentStep, WarframeSupportedPlatform? platform, bool? isValidData}) {
    return ProfileSetupState(
      currentStep ?? this.currentStep,
      platform: platform ?? this.platform,
      isValidData: isValidData ?? this.isValidData,
    );
  }

  @override
  List<Object?> get props => [currentStep, platform, isValidData];
}
