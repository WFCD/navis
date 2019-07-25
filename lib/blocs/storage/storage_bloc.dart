import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:navis/services/repository.dart';

import 'storage_events.dart';
import 'storage_states.dart';

class StorageBloc extends Bloc<ChangeEvent, StorageState> {
  StorageBloc(this.repository);

  final Repository repository;

  @override
  StorageState get initialState => MainStorageState(repository.storageService);

  @override
  Stream<StorageState> mapEventToState(ChangeEvent event) async* {
    if (event is ChangeDateFormat) {
      repository.storageService.dateformat = event.dateformat;

      yield MainStorageState(repository.storageService);
    }

    if (event is ChangePlatformEvent) {
      repository.storageService.platform = event.platform;
      repository.notificationService.subscribeToPlatform(
          previousPlatform: currentState.platform,
          currentPlatform: event.platform);

      yield MainStorageState(repository.storageService);
    }

    if (event is ToggleNotification) {
      repository.storageService.saveToDisk(
        event.key,
        repository.notificationService
            .subscribeToNotification(event.key, event.value),
      );

      yield MainStorageState(repository.storageService);
    }

    if (event is ToggleDarkMode) {
      repository.storageService.darkMode = event.enableDark;

      yield MainStorageState(repository.storageService);
    }
  }
}
