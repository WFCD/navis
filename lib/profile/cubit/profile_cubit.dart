import 'package:codex/codex.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:profile_models/profile_models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warframe_repository/warframe_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.codex, this.warframe) : super(ProfileInitial());

  final Codex codex;
  final WarframeRepository warframe;

  Future<void> loadProfile(String id) async {
    if (state is! ProfileSuccessful) emit(ProfileUpdating());

    try {
      final profile = await warframe.fetchProfile(id);

      if (isClosed) return;
      emit(ProfileSuccessful(profile));

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_id', id);
      await codex.syncXpInfo(profile.loadout.xpInfo);
    } on Exception {
      if (isClosed) return;
      emit(ProfileFailure());
      rethrow;
    }
  }

  Future<void> refreshProfile() async {
    if (state is! ProfileSuccessful) emit(ProfileUpdating());

    try {
      final prefs = await SharedPreferences.getInstance();
      final id = prefs.getString('profile_id');
      if (id == null) return emit(ProfileFailure());

      final profile = await warframe.fetchProfile(id);
      await codex.syncXpInfo(profile.loadout.xpInfo);

      if (isClosed) return;
      emit(ProfileSuccessful(profile));
    } on Exception {
      if (isClosed) return;
      emit(ProfileFailure());
      rethrow;
    }
  }
}
