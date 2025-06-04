import 'package:equatable/equatable.dart';
import 'package:warframestat_client/warframestat_client.dart';

sealed class SearchState extends Equatable {
  const SearchState();
}

final class CodexSearchEmpty extends SearchState {
  @override
  List<Object> get props => [];
}

final class CodexSearchInProgress extends SearchState {
  @override
  List<Object> get props => [];
}

final class CodexSearchSuccess extends SearchState {
  const CodexSearchSuccess(this.results);

  final List<MinimalItem> results;

  @override
  List<Object?> get props => [results];

  @override
  String toString() => 'CodexSearchSuccess(results: ${results.length})';
}

final class CodexSearchFailure extends SearchState {
  const CodexSearchFailure({required this.error, required this.stackTrace});

  final Exception error;
  final StackTrace stackTrace;

  @override
  List<Object> get props => [error, stackTrace];
}
