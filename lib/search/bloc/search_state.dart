part of 'search_bloc.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

final class SearchEmpty extends SearchState {
  @override
  String toString() => 'CodexSearchEmpty()';
}

final class SearchInProgress extends SearchState {
  @override
  String toString() => 'CodexSearchInProgress()';
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
  String toString() => 'CodexSearchFailure(query: $query)';
}
