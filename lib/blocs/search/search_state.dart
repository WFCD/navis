import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'search_utils.dart';

@immutable
abstract class SearchState extends Equatable {
  SearchState([List props = const <dynamic>[]]) : super(props);
}

class SearchStateLoading extends SearchState {}

class SearchStateEmpty extends SearchState {}

class SearchStateSuccess extends SearchState {
  SearchStateSuccess(this.results, {this.sortBy = Sort.unsorted})
      : super([results]);

  final List<dynamic> results;
  final Sort sortBy;
}

class SearchStateError extends SearchState {
  SearchStateError(this.error) : super([error]);

  final String error;
}

// This is only an erro message for the bloc listener and should be ignore by the bloc builder in codex
class SearchListenerError extends SearchState {
  SearchListenerError(this.error) : super([error]);

  final String error;
}
