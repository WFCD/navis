import 'package:codex/codex.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/settings/settings.dart';
import 'package:warframe_repository/warframe_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(Codex codex, WarframeRepository repo, UserSettings settings)
    : _codex = codex,
      _repo = repo,
      _settings = settings,
      super(ProfileInitial());

  final Codex _codex;
  final WarframeRepository _repo;
  final UserSettings _settings;

  Future<void> saveProfile(String data) async {
    if (state is! ProfileSuccessful) emit(ProfileUpdating());

    try {
      final user = _repo.convertUserData(data);
      final profile = await _repo.fetchProfile(user.id);
      _settings.user = data;

      await _codex.syncXpInfo(profile.loadout.xpInfo);

      if (isClosed) return;
      emit(ProfileSuccessful(user));
    } on Exception {
      if (isClosed) return;
      emit(ProfileFailure());
      rethrow;
    }
  }

  Future<void> refreshProfile() async {
    if (state is! ProfileSuccessful) emit(ProfileUpdating());

    try {
      final data = _settings.user;
      if (data == null) return emit(ProfileInitial());

      final user = _repo.convertUserData(data);
      final profile = await _repo.fetchProfile(user.id);
      await _codex.syncXpInfo(profile.loadout.xpInfo);

      if (isClosed) return;
      emit(ProfileSuccessful(user));
    } on Exception {
      if (isClosed) return;
      emit(ProfileFailure());
      rethrow;
    }
  }
}
