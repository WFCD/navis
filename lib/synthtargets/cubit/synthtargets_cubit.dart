import 'dart:async';
import 'dart:io';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/synthtargets/cubit/synthtargets_state.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:worldstate_repository/worldstate_repository.dart';

export 'synthtargets_state.dart';

enum SynthtargetsEvent { update }

class SynthtargetsCubit extends HydratedCubit<SynthtargetsState> {
  SynthtargetsCubit(this.repository) : super(SynthtargetsInitial());

  final WorldstateRepository repository;

  Future<void> fetchSynthtargets() async {
    try {
      final targets = await repository.getSynthTargets();

      if (isClosed) return;

      emit(TargetsLocated(targets));
    } catch (e) {
      if (e is SocketException) return;

      rethrow;
    }
  }

  @override
  SynthtargetsState fromJson(Map<String, dynamic> json) {
    final targets = json['state'] as List<dynamic>;

    return TargetsLocated(
      targets
          .map((e) => SynthTarget.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  Map<String, dynamic>? toJson(SynthtargetsState state) {
    if (state is TargetsLocated) {
      final targets = state.targets.map((e) => e.toJson()).toList();

      return <String, dynamic>{'state': targets};
    }

    return null;
  }
}
