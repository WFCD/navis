import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:navis/services/localstorage_service.dart';
import 'package:navis/services/notification.dart';
import 'package:navis/services/services.dart';

import 'storage_events.dart';
import 'storage_states.dart';

class StorageBloc extends Bloc<ChangeEvent, StorageState>
    with EquatableMixinBase, EquatableMixin {
  StorageBloc({LocalStorageService instance})
      : _instance = instance ?? locator<LocalStorageService>();

  final LocalStorageService _instance;

  final firebase = locator<NotificationService>();

  @override
  StorageState get initialState => MainStorageState();

  @override
  Stream<StorageState> mapEventToState(ChangeEvent event) async* {
    if (event is ChangeDateFormat) {
      _instance.dateformat = event.dateformat;

      yield MainStorageState();
    }

    if (event is ChangePlatformEvent) {
      _instance.platform = event.platform;
      firebase.subscribeToPlatform(
          previousPlatform: currentState.platform,
          currentPlatform: event.platform);

      yield MainStorageState();
    }

    if (event is ToggleNotification) {
      _instance.saveToDisk(event.key, event.value);
      firebase.subscribeToNotification(event.key, event.value);

      yield MainStorageState();
    }

    if (event is ToggleDarkMode) {
      _instance.darkMode = event.enableDark;

      yield MainStorageState();
    }
  }
}
