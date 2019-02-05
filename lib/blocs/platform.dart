import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bloc/bloc.dart';

class PlatformBloc extends Bloc<PlatformEvent, PlatformState> {
  @override
  Stream<PlatformEvent> transform(Stream<PlatformEvent> events) {
    //ignore: avoid_as
    return (events as Observable<PlatformEvent>).distinct();
  }

  @override
  PlatformState get initialState => PlatformState();

  @override
  Stream<PlatformState> mapEventToState(
      PlatformState currentState, PlatformEvent event) async* {
    if (event is PlatformStart) {
      final prefs = await SharedPreferences.getInstance();
      yield PlatformState(platform: prefs.getString('Platform') ?? 'pc');
    }
    if (event is PlatformChange) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('Platform', event.platform);
      yield PlatformState(platform: event.platform);
    }
  }
}

abstract class PlatformEvent {}

class PlatformState {
  PlatformState({this.platform});

  final String platform;
}

class PlatformStart extends PlatformEvent {}

class PlatformChange extends PlatformEvent {
  PlatformChange({this.platform});

  final String platform;
}
