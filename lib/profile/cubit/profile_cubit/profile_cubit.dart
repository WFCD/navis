import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:navis/utils/utils.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.repository) : super(ProfileInitial());

  final WarframestatRepository repository;

  Future<void> fetchProfile(String username) async {
    emit(const ProfileLoading());
    try {
      final profile = await ConnectionManager.call(
        () => repository.fetchProfile(username),
      );

      emit(ProfileSuccesful(profile));
    } catch (e) {
      emit(ProfileFailure(e.toString()));
    }
  }
}
