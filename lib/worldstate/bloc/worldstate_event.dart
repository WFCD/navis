part of 'worldstate_bloc.dart';

sealed class WorldstateEvent extends ReplayEvent with Equatable {
  const new();

  @override
  List<Object> get props => [];
}

final class WorldstateStarted extends WorldstateEvent {
  const new(this.locale);

  final String locale;

  @override
  List<Object> get props => [locale];

  @override
  String toString() => 'WorldstateStarted(locale: $locale)';
}

final class WorldstateUpdated extends WorldstateEvent {
  const new(this.state);

  final Worldstate state;

  @override
  List<Object> get props => [state];

  @override
  String toString() => 'WorldstateUpdated(state: ${state.timestamp})';
}

final class WorldstateFailed extends WorldstateEvent {
  new();

  @override
  String toString() => 'WorldstateFailed()';
}
