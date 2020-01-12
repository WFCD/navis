import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class TextChanged extends SearchEvent {
  const TextChanged(this.text);

  final String text;

  @override
  List<Object> get props => [text];
}
