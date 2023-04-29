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

      if (info != null) {
        emit(DarvoDealLoaded(info));
        return;
      }

      emit(DarvoDealNoInfo());
    } catch (e) {
      emit(DarvoDealNoInfo());
    }
  }

  @override
  DarvodealState fromJson(Map<String, dynamic> json) {
    final item = json['item'] as Map<String, dynamic>?;

    if (item == null) return DarvodealLoading();

    return DarvoDealLoaded(toItem(item));
  }

  @override
  Map<String, dynamic>? toJson(DarvodealState state) {
    if (state is DarvoDealLoaded) {
      return <String, dynamic>{'item': state.item.toJson()};
    }

    return null;
  }
}
