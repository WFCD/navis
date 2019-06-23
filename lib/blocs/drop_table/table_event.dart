import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  SearchEvent({List props = const []}) : super(props);
}

class TextChanged extends SearchEvent {
  TextChanged({this.text}) : super(props: [text]);

  final String text;
}
