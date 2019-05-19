import 'dart:async';

import 'package:background_fetch/background_fetch.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/screens/home.dart';
import 'package:navis/screens/settings/settings.dart';
import 'package:navis/services/service_locator.dart';

class Navis extends StatefulWidget {
  const Navis();

  @override
  NavisState createState() => NavisState();
}

class NavisState extends State<Navis> with WidgetsBindingObserver {
  final firebase = locator<FirebaseMessaging>();
  Timer timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _init();

    timer = Timer.periodic(
        const Duration(minutes: 7),
        (t) => BlocProvider.of<WorldstateBloc>(context)
            .dispatch(UpdateEvent.update));
    firebase.configure();
  }

  Future<void> _init() async {
    BlocProvider.of<ThemeBloc>(context).dispatch(ThemeStart());
    BlocProvider.of<StorageBloc>(context).dispatch(RestoreEvent());
    BlocProvider.of<WorldstateBloc>(context).dispatch(UpdateEvent.update);

    BackgroundFetch.configure(
        BackgroundFetchConfig(
            minimumFetchInterval: 15,
            startOnBoot: true,
            stopOnTerminate: false,
            enableHeadless: true),
        () => BlocProvider.of<WorldstateBloc>(context)
            .dispatch(UpdateEvent.update));
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      BlocProvider.of<WorldstateBloc>(context).dispatch(UpdateEvent.update);
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    BlocProvider.of<ThemeBloc>(context).dispose();
    BlocProvider.of<StorageBloc>(context).dispose();
    BlocProvider.of<WorldstateBloc>(context).dispose();

    timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeEvent, ThemeState>(
      bloc: BlocProvider.of<ThemeBloc>(context),
      builder: (_, ThemeState themeState) {
        return MaterialApp(
          title: 'Navis',
          color: Colors.grey[900],
          theme: themeState.theme,
          home: HomeScreen(),
          routes: <String, WidgetBuilder>{'/Settings': (_) => const Settings()},
        );
      },
    );
  }
}
