import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:navis/core/error/exceptions.dart';
import 'package:navis/core/usecases/usecases.dart';
import 'package:navis/features/synthtargets/domain/usecases/get_synth_targets.dart';
import 'package:supercharged/supercharged.dart';
import 'package:worldstate_api_model/entities.dart';

part 'synthtargets_state.dart';

enum SynthtargetsEvent { update }

class SynthtargetsBloc extends Bloc<SynthtargetsEvent, SynthtargetsState> {
  SynthtargetsBloc(this.getSynthTargets) {
    add(SynthtargetsEvent.update);
  }

  final GetSynthTargets getSynthTargets;

  @override
  SynthtargetsState get initialState => SynthtargetsInitial();

  @override
  Stream<SynthtargetsState> mapEventToState(
    SynthtargetsEvent event,
  ) async* {
    if (event == SynthtargetsEvent.update) {
      final locating = await getSynthTargets(NoParama());

      yield locating.fold(
        (l) => matchFailure(l),
        (r) => TargetsLocated(r),
      );
    }
  }

  Future<void> refresh() async {
    await Future<void>.delayed(1.seconds, () => add(SynthtargetsEvent.update));
  }
}
