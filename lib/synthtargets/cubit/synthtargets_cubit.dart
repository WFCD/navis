import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warframe_repository/warframe_repository.dart';
import 'package:warframe_worldstate_data/warframe_worldstate_data.dart';

part 'synthtargets_state.dart';

enum SynthtargetsEvent { update }

class SynthtargetsCubit extends Cubit<SynthtargetsState> {
  SynthtargetsCubit(this.repository) : super(SynthtargetsInitial());

  final WarframeRepository repository;

  Future<void> fetchSynthtargets() async {
    final targets = await repository.fetchTargets();
    return emit(TargetsLocated(targets));
  }
}
