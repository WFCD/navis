import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/core/error/exceptions.dart';
import 'package:navis/core/usecases/usecases.dart';
import 'package:navis/features/synthtargets/domain/usecases/get_synth_targets.dart';
import 'package:supercharged/supercharged.dart';
import 'package:warframestat_api_models/entities.dart';
import 'package:warframestat_api_models/models.dart';
import 'package:wfcd_client/wfcd_client.dart';

part 'synthtargets_state.dart';

enum SynthtargetsEvent { update }

class SynthtargetsBloc
    extends HydratedBloc<SynthtargetsEvent, SynthtargetsState> {
  SynthtargetsBloc(this.getSynthTargets) {
    add(SynthtargetsEvent.update);
  }

  final GetSynthTargets getSynthTargets;

  @override
  SynthtargetsState get initialState {
    return super.initialState ?? SynthtargetsInitial();
  }

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

  @override
  SynthtargetsState fromJson(Map<String, dynamic> json) {
    final targets = json['state'] as List<dynamic>;

    return TargetsLocated(toSynthTargets(targets));
  }

  @override
  Map<String, dynamic> toJson(SynthtargetsState state) {
    if (state is TargetsLocated) {
      final targets = state.targets
          .map((dynamic e) => (e as SynthTargetModel).toJson())
          .toList();

      return <String, dynamic>{'state': targets};
    }

    return null;
  }
}
