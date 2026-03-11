import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/utils/bloc_mixin.dart';
import 'package:warframe_repository/warframe_repository.dart';

part 'mastery_state.dart';

class MasteryProgressCubit extends Cubit<MasteryProgressState> with SafeBlocMixin {
  MasteryProgressCubit(this.repository) : super(MasteryProgressInitial());

  final WarframeRepository repository;

  Future<void> fetchInProgress() async {
    await safeEmit(() async {
      final inventory = await repository.buildXpInfo();
      return MasteryProgressSuccess(inventory);
    });
  }
}
