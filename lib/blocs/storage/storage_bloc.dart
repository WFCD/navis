import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:navis/services/localstorage_service.dart';
import 'package:navis/services/notification_service.dart';

import 'storage_events.dart';
import 'storage_states.dart';

class StorageBloc extends Bloc<ChangeEvent, StorageState> {
  StorageBloc(this.storage, this.notifications);

  final LocalStorageService storage;
  final NotificationService notifications;

  @override
  StorageState get initialState => MainStorageState(storage);

  @override
  Stream<StorageState> mapEventToState(ChangeEvent event) async* {
    if (event is ChangeDateFormat) {
      storage.dateformat = event.dateformat;

      yield MainStorageState(storage);
    }

    if (event is ChangePlatformEvent) {
      notifications.subscribeToPlatform(
          previousPlatform: storage.platform, currentPlatform: event.platform);

      storage.platform = event.platform;

      yield MainStorageState(storage);
    }

    if (event is ToggleNotification) {
      storage.saveToDisk(
        event.key,
        notifications.subscribeToNotification(event.key, event.value),
      );

      yield MainStorageState(storage);
    }
  }
}
