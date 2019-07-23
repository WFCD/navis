import 'package:catcher/core/catcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/screens/home.dart';
import 'package:navis/screens/settings/settings.dart';
import 'package:navis/services/repository.dart';

import 'components/widgets.dart';

class Navis extends StatefulWidget {
  const Navis(this.repository);

  final Repository repository;

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
    ErrorWidget.builder =
        (FlutterErrorDetails error) => NavisErrorWidget(details: error);
    return widget;
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: widget.repository,
      child: BlocBuilder<StorageBloc, StorageState>(
        bloc: BlocProvider.of<StorageBloc>(context),
        builder: (BuildContext context, StorageState state) {
          return MaterialApp(
            navigatorKey: Catcher.navigatorKey,
            title: 'Navis',
            color: Colors.grey[900],
            theme: state.theme,
            home: const HomeScreen(),
            builder: _builder,
            routes: <String, WidgetBuilder>{
              '/Settings': (_) => const Settings()
            },
          );
        },
      ),
    );
  }
}
