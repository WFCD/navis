import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/blocs/theming.dart';
import 'package:background_fetch/background_fetch.dart';

import 'package:navis/ui/screens/home.dart';
import 'package:navis/ui/screens/settings/settings.dart';

class Navis extends StatefulWidget {
  @override
  NavisState createState() => NavisState();
}

class NavisState extends State<Navis> {
  final _theme = ThemeBloc();
  final _platform = PlatformBloc();
  final _worldstate = WorldstateBloc();

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    _theme.dispatch(ThemeStart());
    _platform.dispatch(PlatformStart());
    _worldstate.dispatch(UpdateState());

    BackgroundFetch.configure(
        BackgroundFetchConfig(
            startOnBoot: true,
            stopOnTerminate: false,
            enableHeadless: true), () {
      _worldstate.update();
      BackgroundFetch.finish();
    });
  }

  @override
  void dispose() {
    _theme.dispose();
    _platform.dispose();
    _worldstate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        bloc: _theme,
        child: BlocProvider(
            bloc: _platform,
            child: BlocProvider(
              bloc: _worldstate,
              child: BlocBuilder(
                  bloc: _theme,
                  builder: (_, ThemeState themeState) {
                    return MaterialApp(
                      title: 'Navis',
                      color: Colors.grey[900],
                      theme: themeState.theme,
                      home: const HomeScreen(),
                      routes: <String, WidgetBuilder>{
                        '/Settings': (_) => const Settings()
                      },
                    );
                  }),
            )));
  }
}
