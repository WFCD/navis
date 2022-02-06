import 'dart:async';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/worldstate/cubits/deals/darvodeal_state.dart';
import 'package:wfcd_client/wfcd_client.dart';
import 'package:worldstate_repository/worldstate_repository.dart';

class DarvodealCubit extends HydratedCubit<DarvodealState> {
  DarvodealCubit(this.repository) : super(DarvodealInitial());

  final WorldstateRepository repository;

  Future<void> fetchDeal(String id, String name) async {
    emit(DarvodealLoading());

    try {
      final info = await repository.getDealInfo(id, name);
      emit(DarvoDealLoaded(info));
    } catch (e) {
      emit(DarvoDealNoInfo());
    }
  }

  @override
  DarvodealState fromJson(Map<String, dynamic> json) {
    final items = toBaseItem(json['items'] as Map<String, dynamic>);

    return DarvoDealLoaded(items);
  }

  @override
  Map<String, dynamic>? toJson(DarvodealState state) {
    if (state is DarvoDealLoaded) {
      return <String, dynamic>{'items': fromBaseItem(state.item)};
    }

    return null;
  }
}
