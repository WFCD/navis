part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {
  @override
  String toString() => 'ProfileInitial()';
}

final class ProfileUpdating extends ProfileState {
  @override
  String toString() => 'ProfileUpdating()';
}

final class ProfileSuccessful extends ProfileState {
  const ProfileSuccessful(this.profile);

  final Profile profile;

  @override
  List<Object> get props => [profile];

  @override
  String toString() => 'ProfileSuccessful(profile: ${profile.id})';
}

final class ProfileFailure extends ProfileState {
  const ProfileFailure([this.message]);

  final dynamic message;

  @override
  List<Object> get props => [message as Object];

  @override
  String toString() => 'ProfileFailure(data: $message)';
}
