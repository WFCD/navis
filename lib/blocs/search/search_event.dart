import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'search_utils.dart';

@immutable
abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => const [];
}

class TextChanged extends SearchEvent {
  const TextChanged(this.text, {this.type}) : super();

  final String text;
  final SearchTypes type;

  @override
  List<Object> get props => [text, type];
}

class SortSearch extends SearchEvent {
  const SortSearch(this.sortBy, this.results);

  final List<dynamic> results;
  final Sort sortBy;

  @override
  List<Object> get props => [sortBy, results];
}

class SearchError extends SearchEvent {
  const SearchError(this.error);

  final dynamic error;

  @override
  List<Object> get props => [error];
}
