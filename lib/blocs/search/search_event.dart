import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'search_utils.dart';

@immutable
abstract class SearchEvent extends Equatable {
  const SearchEvent([List props = const <dynamic>[]]) : super(props);
}

class TextChanged extends SearchEvent {
  TextChanged(this.text, {this.type}) : super([text, type]);

  final String text;
  final SearchTypes type;
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
