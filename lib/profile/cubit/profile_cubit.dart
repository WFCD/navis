import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/utils/bloc_mixin.dart';
import 'package:profile_models/profile_models.dart';
import 'package:warframe_repository/warframe_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> with SafeBlocMixin {
  ProfileCubit(WarframeRepository repo) : _repo = repo, super(ProfileInitial());

  final WarframeRepository _repo;

  Future<void> saveProfile(String data) async {
    if (state is! ProfileSuccessful) emit(ProfileUpdating());

    await safeEmit(
      () async {
        await _repo.updateAccountId(data);

        final profile = await _repo.fetchProfile();
        if (profile == null) return ProfileInitial();

        return ProfileSuccessful(profile);
      },
      onError: (_, _) => ProfileFailure(),
    );
  }

  Future<void> refreshProfile() async {
    if (state is! ProfileSuccessful) emit(ProfileUpdating());

    await safeEmit(
      () async {
        final profile = await _repo.fetchProfile();
        if (profile == null) return ProfileInitial();

        return ProfileSuccessful(profile);
      },
      onError: (_, _) => ProfileFailure(),
    );
  }
}
