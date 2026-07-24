import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/utils/bloc_mixin.dart';
import 'package:profile_repository/profile_repository.dart';
import 'package:settings_repository/settings_repository.dart';
import 'package:warframe_api/warframe_api.dart';
import 'package:warframe_common/warframe_common.dart' hide ProfileNotFound;

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> with SafeBlocMixin {
  ProfileCubit(this._repo, this._settings) : super(ProfileInitial());

  final ProfileRepository _repo;
  final SettingsRepository _settings;

  Future<void> refreshProfile() async {
    if (state is! ProfileSuccessful) emit(ProfileUpdating());

    final data = _settings.accountId;
    if (data == null) return emit(ProfileInitial());

    final platform = WarframeSupportedPlatform.values[_settings.platform ?? 0];
    await safeEmit(
      () async {
        final profile = await _repo.fetchProfile(platform, data);
        await _repo.buildXpInfo();

        return ProfileSuccessful(profile, _repo.xpInfo);
      },
      onError: (_, _) => const ProfileFailure(),
    );
  }

  @override
  String toString() => 'ProfileCubit()';
}
