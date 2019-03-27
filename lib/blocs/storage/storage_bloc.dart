import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'storage_events.dart';
import 'storage_states.dart';
import 'storage_utils.dart';

class StorageBloc extends Bloc<ChangeEvent, StorageState>
    with EquatableMixinBase, EquatableMixin {
  @override
  StorageState get initialState => AppStart();

  @override
  Stream<StorageState> mapEventToState(
      StorageState currentState, ChangeEvent event) async* {
    if (event is RestoreEvent) yield await restore();

    if (event is ChangeDateFormat)
      yield await saveDateFormat(currentState, event.dateformat);

    if (event is ChangePlatformEvent)
      yield await savePlatform(currentState, event.platform);
  }

  void onPressedPlatform(Platforms plat) {
    final platform = plat.toString().split('.').last;
    dispatch(ChangePlatformEvent(platform));
  }

  void onPressedDateFormat(Formats format) =>
      dispatch(ChangeDateFormat(format));
}
