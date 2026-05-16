import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/settings/settings.dart';
import 'package:navis/utils/bloc_mixin.dart';
import 'package:navis_codex/navis_codex.dart';
import 'package:warframe_api/warframe_api.dart';
import 'package:warframe_repository/warframe_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> with SafeBlocMixin {
  ProfileCubit(CodexDatabase codex, WarframeRepository repo, UserSettings settings)
    : _codex = codex,
      _repo = repo,
      _settings = settings,
      super(ProfileInitial());

  final CodexDatabase _codex;
  final WarframeRepository _repo;
  final UserSettings _settings;

  Future<void> saveProfile(String data) async {
    if (state is! ProfileSuccessful) emit(ProfileUpdating());

    await safeEmit(
      () async {
        if (!_repo.verifyUserData(data)) return ProfileFailure();

        final user = UserData.raw(data);
        final profile = await _repo.fetchProfile(user.id);
        _settings.user = user.toJson();

        await _codex.syncXpInfo(profile.loadout.xpInfo);

        return ProfileSuccessful(user);
      },
      onError: (_, _) => ProfileFailure(),
    );
  }

  Future<void> refreshProfile() async {
    if (state is! ProfileSuccessful) emit(ProfileUpdating());

    await safeEmit(
      () async {
        final data = _settings.user;
        if (data == null) return ProfileInitial();

        final user = UserData.fromJson(data);
        final profile = await _repo.fetchProfile(user.id);
        await _codex.syncXpInfo(profile.loadout.xpInfo);

        return ProfileSuccessful(user);
      },
      onError: (_, _) => ProfileFailure(),
    );
  }
}
