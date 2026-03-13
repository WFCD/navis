import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:navis_settings/navis_settings.dart';

part 'toggle_filters_event.dart';
part 'toggle_filters_state.dart';

class ToggleFiltersBloc extends Bloc<ToggleFiltersEvent, ToggleFiltersState> {
  ToggleFiltersBloc(SettingsDatabase db) : _toggles = TogglesAccessor(db), super(ToggleFiltersInitial()) {
    on<ToggleUpdatesSubscriptionRequest>(_onAppConfigSubReq);
    on(updateSettings);
  }

  final TogglesAccessor _toggles;

  Future<void> updateSettings(ToggleUpdate event, Emitter<ToggleFiltersState> emit) async {
    await _toggles.updateToggles(
      enableGiftAlerts: event.enableGiftAlerts,
      enableOperationAlerts: event.enableOperationAlerts,
      enableBaroAlerts: event.enableBaroAlerts,
      enableDarvoAlerts: event.enableDarvoAlerts,
      enableSorieAlerts: event.enableSorieAlerts,
      enableArchonAlerts: event.enableArchonAlerts,
      enablePrimeAccess: event.enablePrimeAccess,
      enableStreams: event.enableStreams,
      enableUpdates: event.enableUpdates,
    );
  }

  Future<void> _onAppConfigSubReq(ToggleFiltersEvent event, Emitter<ToggleFiltersState> emit) async {
    return emit.onEach(
      _toggles.watchSettings(),
      onData: (toggles) => emit(
        ToggleUpdated(
          enableGiftAlerts: toggles.enableGiftAlerts,
          enableOperationAlerts: toggles.enableOperationAlerts,
          enableBaroAlerts: toggles.enableBaroAlerts,
          enableDarvoAlerts: toggles.enableDarvoAlerts,
          enableSorieAlerts: toggles.enableSorieAlerts,
          enableArchonAlerts: toggles.enableArchonAlerts,
          enablePrimeAccess: toggles.enablePrimeAccess,
          enableStreams: toggles.enableStreams,
          enableUpdates: toggles.enableUpdates,
        ),
      ),
      onError: addError,
    );
  }
}
