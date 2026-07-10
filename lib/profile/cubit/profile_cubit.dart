import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/utils/bloc_mixin.dart';
import 'package:profile_repository/profile_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:settings_repository/settings_repository.dart';
import 'package:warframe_api/warframe_api.dart';
import 'package:warframe_common/warframe_common.dart' hide ProfileNotFound;

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> with SafeBlocMixin {
  ProfileCubit(this._repo, this._settings) : super(ProfileInitial());

  final ProfileRepository _repo;
  final SettingsRepository _settings;

  Future<void> loadProfile(String data) async {
    if (state is! ProfileSuccessful) emit(ProfileUpdating());

    await safeEmit(
      () async {
        try {
          final profile = await _repo.fetchProfile(data);
          final xpInfo = await _repo.buildXpInfo();
          _settings.accountId = data;

          return ProfileSuccessful(profile, xpInfo);
        } on ProfileNotFound catch (e) {
          await Sentry.addBreadcrumb(Breadcrumb(message: e.toString(), data: {'user_data': data}));
          rethrow;
        } on FormatException catch (e) {
          return ProfileFailure(e);
        }
      },
      onError: (_, _) => const ProfileFailure(),
    );
  }

  Future<void> refreshProfile() async {
    if (state is! ProfileSuccessful) emit(ProfileUpdating());
    final data = _settings.accountId;

    await safeEmit(
      () async {
        if (data == null) return ProfileInitial();
        final profile = await _repo.fetchProfile(data);
        final xpInfo = await _repo.buildXpInfo();

        return ProfileSuccessful(profile, xpInfo);
      },
      onError: (_, _) => const ProfileFailure(),
    );
  }

  @override
  String toString() => 'ProfileCubit()';
}
