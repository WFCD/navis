part of 'mastery_search_bloc.dart';

sealed class MasterySearchState extends Equatable {
  const MasterySearchState();

  @override
  List<Object> get props => [];
}

final class MasterySearchEmpty extends MasterySearchState {
  @override
  String toString() => 'MasterySearchEmpty()';
}

final class MasterySearchInProgress extends MasterySearchState {
  @override
  String toString() => 'MasterySearchInProgress()';
}

final class MasterySearchSuccessful extends MasterySearchState {
  const MasterySearchSuccessful(this.results);

  final List<MasterableItem> results;

  @override
  List<Object> get props => [results];

  @override
  String toString() => 'MasterySearchSuccessful(results: ${results.length})';
}

final class MasterySearchFailure extends MasterySearchState {
  const MasterySearchFailure(this.query);

  final String query;

  @override
  String toString() => 'MasterySearchFailure(query: $query)';
}
