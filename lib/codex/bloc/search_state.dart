import 'package:equatable/equatable.dart';
import 'package:navis_codex/navis_codex.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

final class CodexSearchEmpty extends SearchState {
  @override
  String toString() => 'CodexSearchEmpty()';
}

final class CodexSearchInProgress extends SearchState {
  @override
  String toString() => 'CodexSearchInProgress()';
}

final class CodexSearchSuccess extends SearchState {
  const CodexSearchSuccess(this.results);

  final List<CodexItem> results;

  @override
  List<Object?> get props => [results];

  @override
  String toString() => 'CodexSearchSuccess(results: ${results.length})';
}

final class CodexSearchFailure extends SearchState {
  const CodexSearchFailure();

  @override
  String toString() => 'CodexSearchFailure()';
}
