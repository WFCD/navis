import 'dart:async';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/utils/utils.dart';
import 'package:navis/worldstate/cubits/deals/darvodeal_state.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:worldstate_repository/worldstate_repository.dart';

class DarvodealCubit extends HydratedCubit<DarvodealState> {
  DarvodealCubit(this.repository) : super(DarvodealInitial());

  final WorldstateRepository repository;

  Future<void> fetchDeal(String uniqueName, String name) async {
    emit(DarvodealLoading());

    try {
      Item? info;
      if (await hasInternetConnection) {
        info = await repository.getDealInfo(uniqueName, name);
      }

      info = await onReconnect(
        () async => repository.getDealInfo(uniqueName, name),
      );

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

    return DarvoDealLoaded(MinimalItem.fromJson(json));
  }

  @override
  Map<String, dynamic>? toJson(DarvodealState state) {
    if (state is DarvoDealLoaded) {
      return <String, dynamic>{'item': state.item.toJson()};
    }

    return null;
  }
}