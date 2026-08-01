import 'dart:async';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/utils/bloc_mixin.dart';
import 'package:warframe_common/warframe_common.dart';

part 'synthtargets_state.dart';

enum SynthtargetsEvent { update }

class SynthtargetsCubit extends Cubit<SynthtargetsState> with SafeBlocMixin {
  SynthtargetsCubit() : super(SynthtargetsInitial());

  Future<void> fetchSynthtargets(String locale) async {
    await safeEmit(() async {
      final l = WorldstateDataLocale.values.firstWhereOrNull((v) => v.name == locale) ?? .en;
      final targets = synthTargets(l);
      return TargetsLocated(targets);
    });
  }

  @override
  String toString() => 'SynthtargetsCubit()';
}
