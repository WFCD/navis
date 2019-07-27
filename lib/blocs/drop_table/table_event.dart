import 'package:equatable/equatable.dart';

enum SearchSort { chanceHL, chanceLH, abc }

abstract class SearchEvent extends Equatable {
  SearchEvent([List props = const []]) : super(props);
}

class TextChanged extends SearchEvent {
  TextChanged({this.text}) : super([text]);

  final String text;
}

class SortEvent extends SearchEvent {
  SortEvent(this.sort) : super([sort]);

  final SearchSort sort;
}
