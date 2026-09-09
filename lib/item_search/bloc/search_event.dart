part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const new();
}

sealed class SearchTextChanged extends SearchEvent {
  const new(this.text);

  final String text;

  @override
  List<Object> get props => [text];

  @override
  String toString() => 'SearchTextChanged($text)';
}

final class ItemsSearchTextChanged extends SearchTextChanged {
  const new(super.text);

  @override
  String toString() => 'CodexSearchTextChanged($text)';
}

final class RelicSearchTextChanged extends SearchTextChanged {
  const new(super.text);

  @override
  String toString() => 'RelicSearchTextChanged($text)';
}

final class ItemResultsFiltered extends SearchEvent {
  const new(this.type);

  final ItemType? type;

  @override
  List<Object?> get props => [type];

  @override
  String toString() => 'SearchResultsFiltered($type)';
}
