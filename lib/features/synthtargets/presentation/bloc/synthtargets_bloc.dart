import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:supercharged/supercharged.dart';
import 'package:wfcd_client/entities.dart';
import 'package:wfcd_client/models.dart';
import 'package:wfcd_client/wfcd_client.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/usecases/usecases.dart';
import '../../domain/usecases/get_synth_targets.dart';

part 'synthtargets_state.dart';

enum SynthtargetsEvent { update }

class SynthtargetsBloc
    extends HydratedBloc<SynthtargetsEvent, SynthtargetsState> {
  SynthtargetsBloc(this.getSynthTargets) : super(SynthtargetsInitial()) {
    on<SynthtargetsEvent>(_locateTargets);
    add(SynthtargetsEvent.update);
  }

  final GetSynthTargets getSynthTargets;

  Future<void> _locateTargets(
    SynthtargetsEvent event,
    Emitter<SynthtargetsState> emit,
  ) async {
    if (event == SynthtargetsEvent.update) {
      final locating = await getSynthTargets(NoParama());

      emit(locating.match((r) => TargetsLocated(r), matchFailure));
    }
  }

  Future<void> refresh() async {
    await Future<void>.delayed(1.seconds, () => add(SynthtargetsEvent.update));
  }

  @override
  SynthtargetsState fromJson(Map<String, dynamic> json) {
    final targets = json['state'] as List<dynamic>;

    return TargetsLocated(toSynthTargets(targets));
  }

  @override
  Map<String, dynamic>? toJson(SynthtargetsState state) {
    if (state is TargetsLocated) {
      final targets = state.targets
          .map((dynamic e) => (e as SynthTargetModel).toJson())
          .toList();

      return <String, dynamic>{'state': targets};
    }

    return null;
  }
}
