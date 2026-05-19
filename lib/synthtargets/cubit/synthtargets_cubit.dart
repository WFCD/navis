import 'dart:async';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/synthtargets/cubit/synthtargets_state.dart';
import 'package:navis/utils/bloc_mixin.dart';
import 'package:warframe_repository/warframe_repository.dart';

export 'synthtargets_state.dart';

enum SynthtargetsEvent { update }

class SynthtargetsCubit extends Cubit<SynthtargetsState> with SafeBlocMixin {
  SynthtargetsCubit(this.repository) : super(SynthtargetsInitial());

  final WarframeRepository repository;

  Future<void> fetchSynthtargets() async {
    await safeEmit(() async {
      final targets = repository.targets();
      return TargetsLocated(targets);
    });
  }

  @override
  String toString() => 'SynthtargetsCubit()';
}
