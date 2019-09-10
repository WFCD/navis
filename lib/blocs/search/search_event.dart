import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'search_utils.dart';

@immutable
abstract class SearchEvent extends Equatable {
  SearchEvent([List props = const <dynamic>[]]) : super(props);
}

class TextChanged extends SearchEvent {
  TextChanged(this.text) : super([text]);

  final String text;
}

class SwitchSearchType extends SearchEvent {
  SwitchSearchType(this.searchType) : super([searchType]);

  final SearchTypes searchType;
}

class SortSearch extends SearchEvent {
  SortSearch(this.sortBy, this.results) : super([sortBy, results]);

  final List<dynamic> results;
  final Sort sortBy;
}

class SearchError extends SearchEvent {
  SearchError(this.error) : super([error]);

  final dynamic error;
}
