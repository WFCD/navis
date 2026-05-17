import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/settings/settings.dart';
import 'package:navis/utils/bloc_mixin.dart';
import 'package:profile_models/profile_models.dart';
import 'package:warframe_api/warframe_api.dart';
import 'package:warframe_repository/warframe_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> with SafeBlocMixin {
  ProfileCubit(WarframeRepository repo, UserSettings settings)
    : _repo = repo,
      _settings = settings,
      super(ProfileInitial());

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

        return ProfileSuccessful(user, profile.loadout.xpInfo);
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

        return ProfileSuccessful(user, profile.loadout.xpInfo);
      },
      onError: (_, _) => ProfileFailure(),
    );
  }
}
