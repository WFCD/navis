import 'dart:async';

import 'package:background_fetch/background_fetch.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/screens/home.dart';
import 'package:navis/screens/settings/settings.dart';
import 'package:navis/services/notification_service.dart';
import 'package:navis/services/worldstate.dart';

class Navis extends StatefulWidget {
  const Navis();

  @override
  NavisState createState() => NavisState();
}

class NavisState extends State<Navis> with WidgetsBindingObserver {
  Timer timer;

  final _messaging = FirebaseMessaging();
  final theme = ThemeBloc();
  final storage = StorageBloc();
  final worldstate = WorldstateBloc.initialize();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _init();
    _messaging.configure();

    timer = Timer.periodic(const Duration(minutes: 7),
        (t) => worldstate.dispatch(UpdateEvent.update));
  }

  Future<void> _init() async {
    theme.dispatch(ThemeStart());
    storage.dispatch(RestoreEvent());
    worldstate.dispatch(UpdateEvent.update);

    BackgroundFetch.configure(
        BackgroundFetchConfig(
            minimumFetchInterval: 15,
            startOnBoot: true,
            stopOnTerminate: false,
            enableHeadless: true),
        () => backgroundTask());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      worldstate.dispatch(UpdateEvent.update);
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    theme.dispose();
    storage.dispose();
    worldstate.dispose();
    timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>(
        bloc: theme,
        child: BlocProvider<StorageBloc>(
            bloc: storage,
            child: BlocProvider<WorldstateBloc>(
              bloc: worldstate,
              child: BlocBuilder(
                  bloc: theme,
                  builder: (_, ThemeState themeState) {
                    return MaterialApp(
                      title: 'Navis',
                      color: Colors.grey[900],
                      theme: themeState.theme,
                      home: HomeScreen(),
                      routes: <String, WidgetBuilder>{
                        '/Settings': (_) => const Settings()
                      },
                    );
                  }),
            )));
  }
}

Future<void> backgroundTask() async {
  final worldstate = WorldstateAPI();

  callNotifications(await worldstate.getWorldstate());
  BackgroundFetch.finish();
}
