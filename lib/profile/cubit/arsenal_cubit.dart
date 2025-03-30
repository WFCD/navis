import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:inventoria/inventoria.dart';
import 'package:logging/logging.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

part 'arsenal_state.dart';

class ArsenalCubit extends Cubit<ArsenalState> {
  ArsenalCubit(this.inventoria) : super(ArsenalInitial());

  final Inventoria inventoria;

  static final _logger = Logger('arsenal_cubit');

  Future<void> syncXpInfo() async {
    // Only update the state when it's not already loaded so the current stays
    // in view until the new one is loaded
    if (state is! ArsenalSuccess) emit(ArsenalUpdating());

    _logger.info('Fetching profile');
    final profile = await inventoria.fetchProfile();
    if (profile == null) return emit(ArsenalInitial());

    try {
      _logger.info('Updating profile');
      await inventoria.updateProfile(profile.id);

      _logger.info('Fetching full inventory');
      final inventory =
          (await inventoria.fetchInventory()).whereNot((i) => i.isHidden).toList()
            ..sort((a, b) => a.xp.compareTo(b.xp));

      emit(ArsenalSuccess(List.unmodifiable(inventory)));
    } on Exception catch (e, stack) {
      _logger.shout('Failed to get inventory', e, stack);
      emit(ArsenalFailure());
      await Sentry.captureException(e, stackTrace: stack);
    }
  }
}
