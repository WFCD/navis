import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/utils/bloc_mixin.dart';
import 'package:navis_codex/navis_codex.dart';

part 'mastery_state.dart';

class MasteryProgressCubit extends Cubit<MasteryProgressState> with SafeBlocMixin {
  MasteryProgressCubit(this.codex) : super(MasteryProgressInitial());

  final CodexDatabase codex;

  static const _overrides = <String>['Excalibur Prime', 'Lato Prime', 'Skana Prime'];

  Future<void> fetchInProgress() async {
    await safeEmit(() async {
      final inventory = await codex.buildXpInfo();
      inventory
        // User either has it or not, mainly founders items
        ..removeWhere((i) => _overrides.contains(i.item.name))
        ..sort((a, b) => a.xp.compareTo(b.xp));

      return MasteryProgressSuccess(inventory);
    });
  }
}
