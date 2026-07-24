part of 'search_bloc.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

final class SearchEmpty extends SearchState {
  @override
  String toString() => 'SearchEmpty()';
}

final class SearchInProgress extends SearchState {
  @override
  String toString() => 'SearchInProgress()';
}

final class SearchSuccessful extends SearchState {
  const SearchSuccessful(this.results);

  final List<WarframeItem> results;

  @override
  List<Object?> get props => [results];

  @override
  String toString() => 'SearchSuccessful(results: ${results.length})';
}

final class SearchFailure extends SearchState {
  const SearchFailure(this.query);

  final String query;

  @override
  String toString() => 'SearchFailure(query: $query)';
}
