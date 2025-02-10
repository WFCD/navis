import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

part 'arsenal_state.dart';

class ArsenalCubit extends HydratedCubit<ArsenalState> {
  ArsenalCubit(this.repository) : super(ArsenalInitial());

  final WarframestatRepository repository;

  late List<MasteryProgress> _xpInfo;

  Future<void> fetchXpInfo() async {
    // Only update the state when it's not already loaded so the current stays
    // in view until the new one is loaded
    if (state is! ArsenalSuccess) emit(ArsenalUpdating());

    try {
      _xpInfo = await repository.fetchXpInfo();

      emit(ArsenalSuccess(_xpInfo));
    } on Exception catch (e, stack) {
      emit(ArsenalFailure());
      await Sentry.captureException(e, stackTrace: stack);
    }
  }

  @override
  ArsenalState? fromJson(Map<String, dynamic> json) {
    final progressList = json['inProgress'] as List;
    final inProgess = List<Map<String, dynamic>>.from(progressList).map(
      (m) => MasteryProgress(
        item: MinimalItem.fromJson(m['item'] as Map<String, dynamic>),
        xp: m['xp'] as int,
        missing: m['missing'] as bool,
      ),
    );

    return ArsenalSuccess(inProgess.toList());
  }

  @override
  Map<String, dynamic>? toJson(ArsenalState state) {
    if (state is! ArsenalSuccess) return null;

    return {
      'inProgress': state.xpInfo.where((i) => !i.missing).map((p) {
        return {
          'item': p.item.toJson(),
          'xp': p.xp,
          'missing': p.missing,
        };
      }).toList(),
    };
  }
}
