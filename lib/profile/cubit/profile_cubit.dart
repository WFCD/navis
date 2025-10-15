import 'package:codex/codex.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.codex) : super(ProfileInitial());

  final Codex codex;

  Future<void> loadProfile(String id) async {
    if (state is! ProfileSuccessful) emit(ProfileUpdating());

    try {
      var profile = await codex.fetchProfile();
      profile ??= await codex.syncProfile(id);

      if (isClosed) return;
      emit(ProfileSuccessful(profile));
    } on Exception {
      if (isClosed) return;
      emit(ProfileFailure());
      rethrow;
    }
  }

  Future<void> reset() async {
    await codex.resetProfile();
    emit(ProfileInitial());
  }

  Future<void> syncProfile() async {
    if (state is! ProfileSuccessful) emit(ProfileUpdating());

    try {
      var profile = await codex.fetchProfile();
      if (profile == null) return emit(ProfileInitial());
      profile = await codex.syncProfile(profile.playerId);

      if (isClosed) return;
      emit(ProfileSuccessful(profile));
    } on Exception {
      if (isClosed) return;
      emit(ProfileFailure());
      rethrow;
    }
  }
}
