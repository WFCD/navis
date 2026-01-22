part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileUpdating extends ProfileState {}

final class ProfileSuccessful extends ProfileState {
  const ProfileSuccessful(this.profile);

  final Profile profile;

  @override
  List<Object> get props => [profile];

  @override
  String toString() => 'ProfileSuccessful(profile: ${profile.id})';
}

final class ProfileFailure extends ProfileState {}
