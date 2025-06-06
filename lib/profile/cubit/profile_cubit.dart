import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:inventoria/inventoria.dart';
import 'package:logging/logging.dart';

part 'profile_state.dart';

class ProfileCubit extends HydratedCubit<ProfileState> {
  ProfileCubit(this.inventoria) : super(ProfileInitial());

  final Inventoria inventoria;

  final _logger = Logger('ProfileCubit');

  Future<void> loadProfile(String id) async {
    if (state is! ProfileSuccessful) emit(ProfileUpdating());

    try {
      final profile = await inventoria.fetchProfile();
      if (profile?.id != id) await inventoria.updateProfile(id);

      if (isClosed) return;
      emit(ProfileSuccessful((await inventoria.fetchProfile())!));
    } on Exception {
      if (isClosed) return;
      emit(ProfileFailure());
      rethrow;
    }
  }

  Future<void> reset() async {
    await inventoria.reset();
    emit(ProfileInitial());
  }

  Future<void> update() async {
    if (state is! ProfileSuccessful) emit(ProfileUpdating());

    try {
      final profile = await inventoria.fetchProfile();
      if (profile == null) return emit(ProfileInitial());

      await inventoria.updateProfile(profile.id);

      if (isClosed) return;
      emit(ProfileSuccessful((await inventoria.fetchProfile())!));
    } on Exception catch (e, stack) {
      _logger.severe('Failed to set profile', e, stack);
      if (isClosed) return;
      emit(ProfileFailure());
    }
  }

  @override
  ProfileState? fromJson(Map<String, dynamic> json) {
    final profile = DriftProfileData.fromJson(json);

    _logger.info('Hydrating ProfileState');
    return ProfileSuccessful(profile);
  }

  @override
  Map<String, dynamic>? toJson(ProfileState state) {
    if (state is! ProfileSuccessful) return null;

    _logger.info('Caching profile');
    return state.profile.toJson();
  }
}
