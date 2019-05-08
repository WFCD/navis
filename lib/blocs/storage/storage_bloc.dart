import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'storage_events.dart';
import 'storage_states.dart';

class StorageBloc extends Bloc<ChangeEvent, StorageState>
    with EquatableMixinBase, EquatableMixin {
  @override
  StorageState get initialState => AppStart();

  @override
  Stream<StorageState> mapEventToState(ChangeEvent event) async* {
    final state = MainStorageState();

    if (event is RestoreEvent) {
      await state.getPreferences();
      yield state;
    }

    if (event is ChangeDateFormat) {
      state.saveDateFormat(event.dateformat);
      await state.getPreferences();
      yield state;
    }

    if (event is ChangePlatformEvent) {
      state.savePlatform(event.platform);
      await state.getPreferences();
      yield state;
    }

    if (event is ToggleNotification) {
      // need to populate missions and acolytes list with empty list on first install
      await state.getPreferences();

      if (event.option != null)
        state.toggleOption(event.key, event.value, event.option);
      else
        state.toggleOption(event.key, event.value);

      await state.getPreferences();
      yield state;
    }
  }
}
