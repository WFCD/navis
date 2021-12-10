import 'dart:async';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/synthtargets/cubit/synthtargets_state.dart';
import 'package:wfcd_client/models.dart';
import 'package:wfcd_client/wfcd_client.dart';
import 'package:worldstate_repository/worldstate_repository.dart';

export 'synthtargets_state.dart';

enum SynthtargetsEvent { update }

class SynthtargetsCubit extends HydratedCubit<SynthtargetsState> {
  SynthtargetsCubit(this.repository) : super(SynthtargetsInitial());

  final WorldstateRepository repository;

  Future<void> fetchSynthtargets() async {
    final targets = await repository.getSynthTargets();

    emit(TargetsLocated(targets));
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
