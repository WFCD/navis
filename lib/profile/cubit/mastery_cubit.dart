import 'package:codex/codex.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'mastery_state.dart';

class MasteryProgressCubit extends Cubit<MasteryProgressState> {
  MasteryProgressCubit(this.codex) : super(MasteryProgressInitial());

  final Codex codex;

  Future<void> fetchInProgress() async {
    try {
      var inventory = await codex.fetchMasterable();
      if (inventory.isEmpty) {
        inventory = await codex.syncXpInfo();
      }

      inventory.sort((a, b) => (a.xpInfo.value?.xp ?? 0).compareTo(b.xpInfo.value?.xp ?? 0));

      if (isClosed) return;
      emit(MasteryProgressSuccess(inventory));
    } on Exception {
      if (isClosed) return;
      emit(MasteryProgressFailure());
    }
  }

  Future<void> syncXpInfo() async {
    try {
      final inventory = await codex.syncXpInfo();
      inventory.sort((a, b) => (a.xpInfo.value?.xp ?? 0).compareTo(b.xpInfo.value?.xp ?? 0));

      if (isClosed) return;
      emit(MasteryProgressSuccess(inventory));
    } on Exception {
      if (isClosed) return;
      emit(MasteryProgressFailure());
    }
  }
}
