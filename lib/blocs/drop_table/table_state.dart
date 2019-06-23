import 'package:equatable/equatable.dart';
import 'package:navis/models/drop_tables/slim.dart';

abstract class SearchState extends Equatable {
  SearchState({List props = const []}) : super(props);
}

class SearchStateEmpty extends SearchState {}

class SearchStateLoading extends SearchState {}

class SearchStateSuccess extends SearchState {
  SearchStateSuccess(this.results) : super(props: [results]);

  final List<Reward> results;
}

class SearchStateError extends SearchState {
  SearchStateError(this.error) : super(props: [error]);

  final String error;
}
