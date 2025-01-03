import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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
      await repository.updateArsenalItems(update: update);

      _xpInfo = await repository.syncXpInfo(username);

      emit(ArsenalSuccess(_xpInfo));
    } catch (e, stack) {
      debugPrint(e.toString());
      emit(ArsenalFailure());

      await Sentry.captureException(e, stackTrace: stack);
    }
  }

  @override
  ArsenalState? fromJson(Map<String, dynamic> json) {
    final inProgess =
        List<Map<String, dynamic>>.from(json['inProgress'] as List).map(
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
      'inProgress': state.inProgress
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
