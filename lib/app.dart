import 'package:background_fetch/background_fetch.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_villains/villain.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/ui/screens/home.dart';
import 'package:navis/ui/screens/settings/settings.dart';

class Navis extends StatefulWidget {
  @override
  NavisState createState() => NavisState();
}

class NavisState extends State<Navis> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _theme = ThemeBloc();
  final _platform = PlatformBloc();
  final _worldstate = WorldstateBloc.initialize();

  @override
  void initState() {
    super.initState();
    _init();

    _firebaseMessaging.configure();
  }

  Future<void> _init() async {
    _theme.dispatch(ThemeStart());
    _platform.dispatch(PlatformStart());

    await Future.delayed(const Duration(milliseconds: 300),
        () => _worldstate.dispatch(UpdateState()));

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
    return BlocProvider<ThemeBloc>(
        bloc: _theme,
        child: BlocProvider<PlatformBloc>(
            bloc: _platform,
            child: BlocProvider<WorldstateBloc>(
              bloc: _worldstate,
              child: BlocBuilder(
                  bloc: _theme,
                  builder: (_, ThemeState themeState) {
                    return MaterialApp(
                      navigatorObservers: [VillainTransitionObserver()],
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
