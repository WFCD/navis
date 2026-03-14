import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/utils/bloc_mixin.dart';
import 'package:navis/utils/connection_manager.dart';
import 'package:warframe_repository/warframe_repository.dart';
import 'package:warframestat_client/warframestat_client.dart';

part 'arbitration_state.dart';

class ArbitrationCubit extends HydratedCubit<ArbitrationState> with SafeBlocMixin {
  ArbitrationCubit(this.repo) : super(ArbitrationInitial());

  final WarframeRepository repo;

  Future<void> fetchArbitrations() async {
    await safeEmit(
      () async {
        final arbit = await ConnectionManager.call(repo.fetchArbitrations);
        return ArbitrationActive(arbitration: arbit);
      },
      onError: (error, stackTrace) {
        addError(error, stackTrace);
        return state;
      },
    );
  }

  @override
  ArbitrationState? fromJson(Map<String, dynamic> json) {
    // ignore: experimental_member_use Will be solid soon
    return ArbitrationActive(arbitration: Arbitration.fromJson(json));
  }

  @override
  Map<String, dynamic>? toJson(ArbitrationState state) {
    if (state is! ArbitrationActive) return null;

    return state.arbitration.toJson();
  }
}
