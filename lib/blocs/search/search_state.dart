import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'search_event.dart';

@immutable
abstract class SearchState extends Equatable {
  SearchState([List props = const <dynamic>[]]) : super(props);
}

class SearchStateLoading extends SearchState {}

class SearchStateEmpty extends SearchState {}

class SearchStateSuccess extends SearchState {
  SearchStateSuccess(this.results, {this.sortBy = Sort.un}) : super([results]);

  final List<dynamic> results;
  final Sort sortBy;
}

class SearchStateError extends SearchState {
  SearchStateError(this.error) : super([error]);

  final String error;
}
