import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/screens/home.dart';
import 'package:navis/screens/settings/settings.dart';
import 'package:navis/services/services.dart';

class Navis extends StatefulWidget {
  const Navis();

  @override
  NavisState createState() => NavisState();
}

class NavisState extends State<Navis> with WidgetsBindingObserver {
  final message = locator<FirebaseMessaging>();
  Timer timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    BlocProvider.of<StorageBloc>(context).dispatch(RestoreEvent());
    BlocProvider.of<WorldstateBloc>(context).dispatch(UpdateEvent.update);
    message.configure();

    timer = Timer.periodic(const Duration(minutes: 7), (t) {
      BlocProvider.of<WorldstateBloc>(context).dispatch(UpdateEvent.update);
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      Future.delayed(
          const Duration(milliseconds: 500),
          () => BlocProvider.of<WorldstateBloc>(context)
              .dispatch(UpdateEvent.update));
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    BlocProvider.of<StorageBloc>(context).dispose();
    BlocProvider.of<WorldstateBloc>(context).dispose();

    timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
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
