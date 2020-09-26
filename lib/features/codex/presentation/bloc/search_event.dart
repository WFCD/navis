import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class SearchCodex extends SearchEvent {
  const SearchCodex(this.text);

  final String text;

  @override
  List<Object> get props => [text];
}

class SearchFilter extends SearchEvent {
  const SearchFilter(this.category);

  final String category;

  @override
  List<Object> get props => [category];
}
