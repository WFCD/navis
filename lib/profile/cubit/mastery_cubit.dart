import 'package:codex/codex.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'mastery_state.dart';

class MasteryProgressCubit extends Cubit<MasteryProgressState> {
  MasteryProgressCubit(this.codex) : super(MasteryProgressInitial());

  final Codex codex;

  static const _overrides = <String>['Excalibur Prime', 'Lato Prime', 'Skana Prime'];

  Future<void> fetchInProgress() async {
    try {
      final inventory = await codex.fetchMasterable();
      inventory
        // User either has it or not, mainly founders items
        ..removeWhere((i) => _overrides.contains(i.name) && i.xpInfo.value == null)
        ..sort((a, b) => (a.xpInfo.value?.xp ?? 0).compareTo(b.xpInfo.value?.xp ?? 0));

      if (isClosed) return;
      emit(MasteryProgressSuccess(inventory));
    } on Exception {
      if (isClosed) return;
      emit(MasteryProgressFailure());
    }
  }
}
