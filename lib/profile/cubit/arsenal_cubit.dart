import 'package:collection/collection.dart';
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

  Future<void> updateArsenal(String username, {bool update = false}) async {
    try {
      emit(ArsenalUpdating());
      _xpInfo = await repository.syncXpInfo(username);

      _xpInfo.sort((a, b) {
        if (a.rank == 0 && b.rank == 0) return 0;
        if (a.rank == 0) return 1;
        if (b.rank == 0) return -1;

        return a.rank.compareTo(b.rank);
      });

      emit(ArsenalSuccess(_xpInfo));

      // Capture all exceptions and pass them to sentry
      // ignore: avoid_catches_without_on_clauses
    } catch (e, stack) {
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
      'inProgress': state.xpInfo
          .map(
            (p) => {
              'item': p.item.toJson(),
              'xp': p.xp,
              'missing': p.missing,
            },
          )
          .toList(),
    };
  }
}
