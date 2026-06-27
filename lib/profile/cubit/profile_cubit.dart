import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/settings/settings.dart';
import 'package:navis/utils/bloc_mixin.dart';
import 'package:profile_models/profile_models.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
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

  Future<void> loadProfile(String data) async {
    if (state is! ProfileSuccessful) emit(ProfileUpdating());

    await safeEmit(
      () async {
        if (!_repo.verifyUserData(data)) return ProfileFailure(data);

        try {
          final profile = await _repo.fetchProfile(data);
          _settings.user = data;

          return ProfileSuccessful(profile);
        } on ProfileNotFound catch (e) {
          await Sentry.addBreadcrumb(Breadcrumb(message: e.toString()));
          rethrow;
        }
      },
      onError: (_, _) => const ProfileFailure(),
    );
  }

  Future<void> refreshProfile() async {
    if (state is! ProfileSuccessful) emit(ProfileUpdating());
    final data = _settings.user;

    await safeEmit(
      () async {
        if (data == null) return ProfileInitial();

        final profile = await _repo.fetchProfile(data);

        return ProfileSuccessful(profile);
      },
      onError: (_, _) => const ProfileFailure(),
    );
  }

  @override
  String toString() => 'ProfileCubit()';
}
