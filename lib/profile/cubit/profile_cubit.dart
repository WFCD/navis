import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:inventoria/inventoria.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.inventoria) : super(ProfileInitial());

  final Inventoria inventoria;

  Future<void> loadProfile(String id) async {
    emit(ProfileUpdating());

    try {
      final profile = await inventoria.fetchProfile();
      if (profile?.id != id) await inventoria.updateProfile(id);

      emit(ProfileSuccessful((await inventoria.fetchProfile())!));
    } on Exception {
      emit(ProfileFailure());
    }
  }

  Future<void> reset() async {
    await inventoria.reset();
    emit(ProfileInitial());
  }

  Future<void> update() async {
    emit(ProfileUpdating());

    try {
      final profile = await inventoria.fetchProfile();
      if (profile == null) return emit(ProfileInitial());

      await inventoria.updateProfile(profile.id);

      emit(ProfileSuccessful((await inventoria.fetchProfile())!));
    } on Exception {
      emit(ProfileFailure());
    }
  }
}
