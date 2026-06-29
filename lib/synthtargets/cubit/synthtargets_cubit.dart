import 'dart:async';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/synthtargets/cubit/synthtargets_state.dart';
import 'package:navis/utils/bloc_mixin.dart';
import 'package:warframe_common/warframe_common.dart';

export 'synthtargets_state.dart';

enum SynthtargetsEvent { update }

class SynthtargetsCubit extends Cubit<SynthtargetsState> with SafeBlocMixin {
  SynthtargetsCubit() : super(SynthtargetsInitial());

  // TODO(Orn): add a locale param
  Future<void> fetchSynthtargets() async {
    await safeEmit(() async {
      final targets = synthTargets();
      return TargetsLocated(targets);
    });
  }

  @override
  String toString() => 'SynthtargetsCubit()';
}
