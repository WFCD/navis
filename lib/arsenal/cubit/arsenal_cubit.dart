import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

part 'arsenal_state.dart';

class ArsenalCubit extends Cubit<ArsenalState> {
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
}
