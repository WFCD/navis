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
  const ProfileSuccessful(this.profile, this.xpInfo);

  final UserData profile;
  final List<XpItem> xpInfo;

  @override
  List<Object> get props => [profile, xpInfo];

  @override
  String toString() => 'ProfileSuccessful(profile: ${profile.id})';
}

final class ProfileFailure extends ProfileState {
  const ProfileFailure(this.data);

  // Doesn't look like there isn't any security issues or tokens passed into the user-data so I figured it's
  // okay to pass for debugging
  final String data;

  @override
  String toString() => 'ProfileFailure(data: $data)';
}
