import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:navis/utils/search_utils.dart';

@immutable
abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => const [];
}

class TextChanged extends SearchEvent {
  const TextChanged(this.text, {this.type});

  final String text;
  final CodexDatabase type;

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
