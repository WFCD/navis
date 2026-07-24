part of 'mastery_search_bloc.dart';

sealed class MasterySearchEvent extends Equatable {
  const MasterySearchEvent();

  @override
  List<Object?> get props => [];
}

final class MasterySearchTextChanged extends MasterySearchEvent {
  const MasterySearchTextChanged(this.text);

  final String text;

  @override
  List<Object?> get props => [text];

  @override
  String toString() => 'MasterySearchTextChanged($text)';
}

final class MasteryResultsFiltered extends MasterySearchEvent {
  const MasteryResultsFiltered(this.type);

  final ItemType? type;

  @override
  List<Object?> get props => [type];

  @override
  String toString() => 'MasterySearchResultsFiltered($type)';
}
