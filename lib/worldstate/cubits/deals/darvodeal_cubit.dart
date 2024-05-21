import 'dart:async';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/utils/utils.dart';
import 'package:navis/worldstate/cubits/deals/darvodeal_state.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:worldstate_repository/worldstate_repository.dart';

class DarvodealCubit extends HydratedCubit<DarvodealState> {
  DarvodealCubit(this.repository) : super(DarvodealInitial());

  final WorldstateRepository repository;

  Future<void> fetchDeal(String uniqueName, String name) async {
    emit(DarvodealLoading());

    try {
      Item? info;
      if (await ConnectionManager.hasInternetConnection) {
        info = await repository.getDealInfo(uniqueName, name);
      }

      info = await ConnectionManager.call(
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
  DarvodealState fromJson(Map<String, dynamic>? json) {
    Sentry.addBreadcrumb(Breadcrumb(message: 'DarvoDealCubit.fromJson'));
    if (json == null) return DarvodealLoading();

    try {
      return DarvoDealLoaded(MinimalItem.fromJson(json));
    } catch (e, s) {
      Sentry.captureException(e, stackTrace: s);
      return DarvodealInitial();
    }
  }

  @override
  Map<String, dynamic>? toJson(DarvodealState state) {
    Sentry.addBreadcrumb(Breadcrumb(message: 'DarvoDealCubit.toJson'));
    if (state is DarvoDealLoaded) {
      return state.item.toJson();
    }

    return null;
  }
}
