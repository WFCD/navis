import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:inventoria/inventoria.dart';
import 'package:navis/profile/utils/extensions.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

part 'arsenal_state.dart';

class ArsenalCubit extends HydratedCubit<ArsenalState> {
  ArsenalCubit(this.inventoria) : super(ArsenalInitial());

  final Inventoria inventoria;

  Future<void> fetchXpInfo() async {
    // Only update the state when it's not already loaded so the current stays
    // in view until the new one is loaded
    if (state is! ArsenalSuccess) emit(ArsenalUpdating());

    final profile = await inventoria.fetchProfile();
    if (profile == null) return emit(ArsenalInitial());

    try {
      await inventoria.updateProfile(profile.id);

      emit(ArsenalSuccess(await inventoria.fetchInventory()));
    } on Exception catch (e, stack) {
      emit(ArsenalFailure());
      await Sentry.captureException(e, stackTrace: stack);
    }
  }

  @override
  ArsenalState? fromJson(Map<String, dynamic> json) {
    final progressList = json['inProgress'] as List;
    final inProgess = List<Map<String, dynamic>>.from(progressList).map(InventoryItemData.fromJson);

    return ArsenalSuccess(inProgess.toList());
  }

  @override
  Map<String, dynamic>? toJson(ArsenalState state) {
    if (state is! ArsenalSuccess) return null;

    return {'inProgress': state.items.where((i) => !i.isMissing).map((p) => p.toJson()).toList()};
  }
}
