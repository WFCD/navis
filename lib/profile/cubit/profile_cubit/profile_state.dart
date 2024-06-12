part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

final class ProfileSuccesful extends ProfileState {
  const ProfileSuccesful(this.profile);

  final Profile profile;

  @override
  List<Object> get props => [profile];
}

final class ProfileFailure extends ProfileState {
  const ProfileFailure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
