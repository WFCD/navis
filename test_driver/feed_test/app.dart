import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/ui/screens/feed/feed.dart';

void main() {
  enableFlutterDriverExtension();

  final bloc = WorldstateBloc.initialize();

  bloc.dispatch(UpdateState());

  runApp(FeedTest(bloc: bloc));
}

class FeedTest extends StatelessWidget {
  const FeedTest({this.bloc});

  final WorldstateBloc bloc;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: BlocProvider<WorldstateBloc>(
        bloc: bloc,
        child: const Scaffold(body: Feed()),
      ),
    );
  }
}
