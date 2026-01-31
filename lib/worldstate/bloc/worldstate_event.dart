part of 'worldstate_bloc.dart';

sealed class WorldstateEvent extends ReplayEvent with EquatableMixin {
  const WorldstateEvent();

  @override
  List<Object> get props => [];
}

final class WorldstateStarted extends WorldstateEvent {
  const WorldstateStarted(this.locale);

  final Locale locale;

  @override
  List<Object> get props => [locale];

  @override
  String toString() => 'WorldstateStarted($locale)';
}

final class WorldstateUpdated extends WorldstateEvent {
  const WorldstateUpdated(this.state);

  final Worldstate state;

  @override
  List<Object> get props => [state];

  @override
  String toString() => 'WorldstateUpdated(state: ${state.timestamp})';
}

final class WorldstateFailed extends WorldstateEvent {
  WorldstateFailed();

  @override
  String toString() => 'WorldstateFailed()';
}
