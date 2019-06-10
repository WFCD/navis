import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:navis/services/localstorage_service.dart';
import 'package:navis/services/services.dart';

import 'storage_events.dart';
import 'storage_states.dart';

class StorageBloc extends Bloc<ChangeEvent, StorageState>
    with EquatableMixinBase, EquatableMixin {
  StorageBloc({LocalStorageService instance})
      : _instance = instance ?? locator<LocalStorageService>();

  final LocalStorageService _instance;

  @override
  StorageState get initialState => AppStart();

  @override
  Stream<StorageState> mapEventToState(ChangeEvent event) async* {
    if (event is RestoreEvent) yield MainStorageState();

    if (event is ChangeDateFormat) {
      _instance.dateformat = event.dateformat;

      yield MainStorageState();
    }

    if (event is ChangePlatformEvent) {
      _instance.platform = event.platform;

      yield MainStorageState();
    }

    if (event is ToggleNotification) {
      _instance.saveToDisk(event.key, event.value);
      _firebaseTopic(event.key, event.value);

      yield MainStorageState();
    }

    if (event is ToggleDarkMode) {
      _instance.darkMode = event.enableDark;

      yield MainStorageState();
    }
  }

  void _firebaseTopic(String key, bool value) {
    final firebase = locator<FirebaseMessaging>();
    final instance = locator<LocalStorageService>();
    final topic = '${instance.platform.toString().split('.').last}_$key';

    if (value)
      firebase.subscribeToTopic(topic);
    else
      firebase.unsubscribeFromTopic(topic);
  }
}
