import 'dart:async';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/worldstate/cubits/deals/darvodeal_state.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:worldstate_repository/worldstate_repository.dart';

class DarvodealCubit extends HydratedCubit<DarvodealState> {
  DarvodealCubit(this.repository) : super(DarvodealInitial());

  final WorldstateRepository repository;

  Future<void> fetchDeal(String id, String name) async {
    emit(DarvodealLoading());

    try {
      final info = await repository.getDealInfo(id, name);

      if (info != null) emit(DarvoDealLoaded(info));

      emit(DarvoDealNoInfo());
    } catch (e) {
      emit(DarvoDealNoInfo());
      rethrow;
    }
  }

  @override
  DarvodealState fromJson(Map<String, dynamic> json) {
    final items = toItem(json['items'] as Map<String, dynamic>);

    return DarvoDealLoaded(items);
  }

  @override
  Map<String, dynamic>? toJson(DarvodealState state) {
    if (state is DarvoDealLoaded) {
      return <String, dynamic>{'items': state.item.toJson()};
    }

    return null;
  }
}
