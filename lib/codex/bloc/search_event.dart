import 'package:equatable/equatable.dart';
import 'package:navis/codex/utils/result_filters.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class SearchCodex extends SearchEvent {
  const SearchCodex(this.text);

  final String text;

  @override
  List<Object> get props => [text];
}

class FilterResults extends SearchEvent {
  const FilterResults(this.category);

  final FilterCategory category;

  @override
  List<Object?> get props => [category];
}
