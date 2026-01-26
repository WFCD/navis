import 'package:codex/codex.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/settings/settings.dart';
import 'package:profile_models/profile_models.dart';
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

  Future<void> loadProfile(String id) async {
    if (state is! ProfileSuccessful) emit(ProfileUpdating());

    try {
      _settings.accountId = id;
      final profile = await _repo.fetchProfile(id);

      if (isClosed) return;
      emit(ProfileSuccessful(profile));

      await _codex.syncXpInfo(profile.loadout.xpInfo);
    } on Exception {
      if (isClosed) return;
      emit(ProfileFailure());
      rethrow;
    }
  }

  Future<void> refreshProfile() async {
    if (state is! ProfileSuccessful) emit(ProfileUpdating());

    try {
      final id = _settings.accountId;
      if (id == null) return emit(ProfileFailure());

      final profile = await _repo.fetchProfile(id);
      await _codex.syncXpInfo(profile.loadout.xpInfo);

      if (isClosed) return;
      emit(ProfileSuccessful(profile));
    } on Exception {
      if (isClosed) return;
      emit(ProfileFailure());
      rethrow;
    }
  }
}
