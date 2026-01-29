import 'dart:async';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/synthtargets/cubit/synthtargets_state.dart';
import 'package:navis/utils/bloc_mixin.dart';
import 'package:navis/utils/utils.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

export 'synthtargets_state.dart';

enum SynthtargetsEvent { update }

class SynthtargetsCubit extends HydratedCubit<SynthtargetsState> with SafeBlocMixin {
  SynthtargetsCubit(this.repository) : super(SynthtargetsInitial());

  final WarframestatRepository repository;

  Future<void> fetchSynthtargets() async {
    await safeEmit(() async {
      final targets = await ConnectionManager.call(repository.fetchTargets);
      return TargetsLocated(targets);
    });
  }

  @override
  SynthtargetsState fromJson(Map<String, dynamic> json) {
    final targets = json['state'] as List<dynamic>;

    logger.info('Hydrating SynthTargets');
    return TargetsLocated(targets.map((e) => SynthTarget.fromJson(e as Map<String, dynamic>)).toList());
  }

  @override
  Map<String, dynamic>? toJson(SynthtargetsState state) {
    if (state is! TargetsLocated) return null;
    logger.info('Storing SynthTargets state');
    final targets = state.targets.map((e) => e.toJson()).toList();

    return <String, dynamic>{'state': targets};
  }
}
