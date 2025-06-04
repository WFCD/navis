import 'package:equatable/equatable.dart';
import 'package:navis/codex/utils/result_filters.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

final class CodexTextChanged extends SearchEvent {
  const CodexTextChanged(this.text);

  final String text;

  @override
  List<Object> get props => [text];

  @override
  String toString() => 'CodexTextChanged($text)';
}

final class CodexResultsFiltered extends SearchEvent {
  const CodexResultsFiltered(this.category);

  final WarframeItemCategory category;

  @override
  List<Object?> get props => [category];

  @override
  String toString() => 'CodexResultsFiltered($category)';
}
