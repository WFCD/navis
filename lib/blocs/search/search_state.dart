import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'search_utils.dart';

@immutable
abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => const [];
}

class SearchStateLoading extends SearchState {}

class SearchStateEmpty extends SearchState {}

class SearchStateSuccess extends SearchState {
  const SearchStateSuccess(this.results, {this.sortBy = Sort.unsorted});

  final List<dynamic> results;
  final Sort sortBy;

  @override
  List<Object> get props => [results, sortBy];
}

class SearchStateError extends SearchState {
  const SearchStateError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}

// This is only an error message for the bloc listener and should be ignore by the bloc builder in codex
class SearchListenerError extends SearchState {
  const SearchListenerError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
