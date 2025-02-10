import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.repository) : super(ProfileInitial());

  final WarframestatRepository repository;

  Future<void> update(String username) async {
    emit(ProfileUpdating());

    try {
      final profile = await repository.fetchProfile(username);
      await repository.syncXpInfo(profile.loadout.xpInfo);

      emit(ProfileSuccessful(profile));
    } on Exception {
      emit(ProfileFailure());
    }
  }
}
