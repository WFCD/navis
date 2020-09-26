import 'package:equatable/equatable.dart';
import 'package:warframestat_api_models/entities.dart';

abstract class SearchState extends Equatable {
  const SearchState();
}

class CodexSearchEmpty extends SearchState {
  @override
  List<Object> get props => [];
}

class CodexSearching extends SearchState {
  @override
  List<Object> get props => [];
}

class CodexSuccessfulSearch extends SearchState {
  const CodexSuccessfulSearch(this.results);

  final List<BaseItem> results;

  @override
  List<Object> get props => [results];
}

class CodexSearchError extends SearchState {
  const CodexSearchError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
