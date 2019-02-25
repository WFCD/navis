import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'platform_events.dart';
import 'platform_states.dart';

enum Platforms { pc, ps4, xb1, swi }

class PlatformBloc extends Bloc<PlatformEvent, PlatformState>
    with EquatableMixinBase, EquatableMixin {
  @override
  Stream<PlatformEvent> transform(Stream<PlatformEvent> events) {
    //ignore: avoid_as
    return (events as Observable<PlatformEvent>)
        .distinct()
        .doOnData(_savePlatform);
  }

  @override
  PlatformState get initialState => KDefaultState();

  @override
  Stream<PlatformState> mapEventToState(
      PlatformState currentState, PlatformEvent event) async* {
    if (event is PlatformStart) {
      final pref = await SharedPreferences.getInstance();

      if (pref.getString('platform') == null)
        await pref.setString('platform', 'pc');

      yield PlatformRestore(pref.getString('platform'));
    }

    switch (event.runtimeType) {
      case PCEvent:
        yield PCState();
        break;
      case PS4Event:
        yield PS4State();
        break;
      case Xb1Event:
        yield Xb1State();
        break;
      case SwitchEvent:
        yield SwitchState();
    }
  }

  void onPressed(Platforms platform, {Future<void> callback}) {
    switch (platform) {
      case Platforms.pc:
        dispatch(PCEvent());
        break;
      case Platforms.ps4:
        dispatch(PS4Event());
        break;
      case Platforms.xb1:
        dispatch(Xb1Event());
        break;
      case Platforms.swi:
        dispatch(SwitchEvent());
        break;
    }

    Future<void>.delayed(const Duration(milliseconds: 500), () => callback);
  }

  Future<void> _savePlatform(PlatformEvent event) async {
    final pref = await SharedPreferences.getInstance();
    const String key = 'platform';

    switch (event.runtimeType) {
      case PCEvent:
        pref.setString(key, 'pc');
        break;
      case PS4Event:
        pref.setString(key, 'ps4');
        break;
      case Xb1Event:
        pref.setString(key, 'xb1');
        break;
      case SwitchEvent:
        pref.setString(key, 'swi');
    }
  }
}
