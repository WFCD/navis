import 'package:flutter_test/flutter_test.dart';
import 'package:navis/core/bloc/navigation_bloc.dart';

void main() {
  NavigationBloc navigationBloc;

  setUp(() {
    navigationBloc = NavigationBloc();
  });

  tearDown(() {
    navigationBloc.close();
  });
}
