import 'package:catcher/core/catcher.dart';
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

  Widget _builder(BuildContext context, Widget widget) {
    Catcher.addDefaultErrorWidget(
        showStacktrace: true,
        customTitle: 'An application Error has occured',
        customDescription: 'There was unexpected error in the application');
    return widget;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeEvent, StorageState>(
      bloc: BlocProvider.of<StorageBloc>(context),
      builder: (_, StorageState state) {
        return MaterialApp(
          navigatorKey: Catcher.navigatorKey,
          title: 'Navis',
          color: Colors.grey[900],
          theme: state.theme,
          home: const HomeScreen(),
          builder: _builder,
          routes: <String, WidgetBuilder>{'/Settings': (_) => const Settings()},
        );
      },
    );
  }
}
