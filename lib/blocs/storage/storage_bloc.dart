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
  final instance = locator<LocalStorageService>();

  @override
  StorageState get initialState => AppStart();

  @override
  Stream<StorageState> mapEventToState(ChangeEvent event) async* {
    if (event is RestoreEvent) yield MainStorageState();

    if (event is ChangeDateFormat) {
      instance.dateformat = event.dateformat;

      yield MainStorageState();
    }

    if (event is ChangePlatformEvent) {
      instance.platform = event.platform;

      yield MainStorageState();
    }

    if (event is ToggleNotification) {
      instance.saveToDisk(event.key, event.value);
      _firebaseTopic(event.key, event.value);

      yield MainStorageState();
    }

    if (event is ChangeThemeData) {
      if (event.enableDark != null) instance.darkMode = event.enableDark;

      if (event.primaryColor != null)
        instance.primaryColor = event.primaryColor;

      if (event.accentColor != null) instance.accentColor = event.accentColor;

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
