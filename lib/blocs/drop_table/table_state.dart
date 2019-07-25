import 'package:equatable/equatable.dart';
import 'package:navis/models/slim_drop_table.dart';

abstract class SearchState extends Equatable {
  SearchState([List props = const []]) : super(props);
}

class SearchStateEmpty extends SearchState {}

class SearchStateLoading extends SearchState {}

class SearchStateSuccess extends SearchState {
  SearchStateSuccess(this.results) : super([results]);

  final List<Drop> results;
}

class SearchStateError extends SearchState {
  SearchStateError(this.error) : super([error]);

  final String error;
}
