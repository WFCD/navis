import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:inventoria/inventoria.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

part 'arsenal_state.dart';

class ArsenalCubit extends Cubit<ArsenalState> {
  ArsenalCubit(this.inventoria) : super(ArsenalInitial());

  final Inventoria inventoria;

  Future<void> syncXpInfo() async {
    // Only update the state when it's not already loaded so the current stays
    // in view until the new one is loaded
    if (state is! ArsenalSuccess) emit(ArsenalUpdating());

    final profile = await inventoria.fetchProfile();
    if (profile == null) return emit(ArsenalInitial());

    try {
      await inventoria.updateProfile(profile.id);

      final inventory =
          (await inventoria.fetchInventory()).whereNot((i) => i.isHidden).toList()
            ..sort((a, b) => a.xp.compareTo(b.xp));

      emit(ArsenalSuccess(List.unmodifiable(inventory)));
    } on Exception catch (e, stack) {
      emit(ArsenalFailure());
      await Sentry.captureException(e, stackTrace: stack);
    }
  }
}
