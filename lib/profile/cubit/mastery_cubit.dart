import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/utils/bloc_mixin.dart';
import 'package:profile_models/profile_models.dart';
import 'package:warframe_repository/warframe_repository.dart';

part 'mastery_state.dart';

class MasteryProgressCubit extends Cubit<MasteryProgressState> with SafeBlocMixin {
  MasteryProgressCubit(WarframeRepository repository) : _repository = repository, super(MasteryProgressInitial());

  final WarframeRepository _repository;

  static const _overrides = <String>['Excalibur Prime', 'Lato Prime', 'Skana Prime'];

  Future<void> fetchInProgress(List<XpItem> items) async {
    await safeEmit(() async {
      final inventory = await _repository.buildXpInfo(items);
      inventory
        // User either has it or not, mainly founders items
        ..removeWhere((i) => _overrides.contains(i.item.name) && i.xp == 0)
        ..sort((a, b) => a.xp.compareTo(b.xp));

      return MasteryProgressSuccess(inventory);
    });
  }
}
