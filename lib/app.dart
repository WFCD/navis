import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/screens/home.dart';
import 'package:navis/screens/settings/settings.dart';

class Navis extends StatefulWidget {
  const Navis();

  @override
  _NavisState createState() => _NavisState();
}

class _NavisState extends State<Navis> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<WorldstateBloc>(context).dispatch(UpdateEvent.update);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeEvent, StorageState>(
      bloc: BlocProvider.of<StorageBloc>(context),
      builder: (_, StorageState state) {
        return MaterialApp(
          title: 'Navis',
          color: Colors.grey[900],
          theme: state.theme,
          home: const HomeScreen(),
          routes: <String, WidgetBuilder>{'/Settings': (_) => const Settings()},
        );
      },
    );
  }
}
