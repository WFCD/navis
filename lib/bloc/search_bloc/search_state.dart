import 'package:equatable/equatable.dart';

abstract class SearchState extends Equatable {
  const SearchState();
}

class SearchStateEmpty extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchStateLoading extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchStateSuccess extends SearchState {
  const SearchStateSuccess(this.results);

  final List results;

  @override
  List<Object> get props => results;
}

class SearchStateError extends SearchState {
  @override
  List<Object> get props => [];
}
