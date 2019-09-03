import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/router.dart';
import 'package:navis/screens/nightwaves.dart';
import 'package:navis/widgets/widgets.dart';
import 'package:navis/screens/app_scaffold.dart';
import 'package:navis/services/repository.dart';
import 'package:wfcd_api_wrapper/worldstate_wrapper.dart';

import 'screens/settings.dart';

class Navis extends StatefulWidget {
  const Navis(this.repository);

  final Repository repository;

  @override
  _NavisState createState() => _NavisState();
}

class _NavisState extends State<Navis> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    BlocProvider.of<WorldstateBloc>(context).dispatch(UpdateEvent.update);

    if (widget.repository.storage?.platform == null) {
      widget.repository.notifications
          .subscribeToPlatform(currentPlatform: Platforms.pc);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      Future.delayed(
        const Duration(seconds: 1),
        () => BlocProvider.of<WorldstateBloc>(context)
            .dispatch(UpdateEvent.update),
      );
    }

    super.didChangeAppLifecycleState(state);
  }

  Widget _builder(BuildContext context, Widget widget) {
    ErrorWidget.builder =
        (FlutterErrorDetails error) => NavisErrorWidget(details: error);
    return widget;
  }

  Widget _blocBuilder(BuildContext context, StorageState state) =>
      const MainScreen();

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: const Color(0xE51A5090),
      accentColor: const Color(0xFF00BC8C),
      cardColor: const Color(0xFF2C2C2C),
      dialogBackgroundColor: const Color(0xFF212121),
      scaffoldBackgroundColor: const Color(0xFF212121),
      canvasColor: const Color(0xFF212121),
      splashColor: const Color(0xFF00BC8C),
    );

    return RepositoryProvider.value(
      value: widget.repository,
      child: MaterialApp(
        title: 'Navis',
        color: Colors.grey[900],
        theme: theme,
        home: BlocBuilder<StorageBloc, StorageState>(
          bloc: BlocProvider.of<StorageBloc>(context),
          builder: _blocBuilder,
        ),
        builder: _builder,
        onGenerateRoute: router.generator,
        routes: <String, WidgetBuilder>{
          '/settings': (_) => const Settings(),
          '/nightwave': (_) => const Nightwaves()
        },
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
