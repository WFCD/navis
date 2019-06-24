import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/components/layout/drawer.dart';
import 'package:navis/global_keys.dart';
import 'package:navis/services/services.dart';
import 'package:simple_animations/simple_animations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  final message = locator<FirebaseMessaging>();
  Timer timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    BlocProvider.of<WorldstateBloc>(context).dispatch(UpdateEvent.update);
    message.configure();

    timer = Timer.periodic(const Duration(minutes: 5), (t) {
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

  Widget _mainBody() {
    return BlocBuilder<RouteEvent, RouteState>(
      bloc: BlocProvider.of<NavigationBloc>(context),
      builder: (BuildContext context, RouteState route) {
        return ControlledAnimation(
          duration: const Duration(milliseconds: 500),
          playback: Playback.PLAY_FORWARD,
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (BuildContext context, dynamic value) =>
              Opacity(opacity: value, child: route.widget),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
          key: scaffold,
          appBar: AppBar(title: const Text('Navis')),
          drawer: const LotusDrawer(),
          body: BlocBuilder<UpdateEvent, WorldStates>(
            bloc: BlocProvider.of<WorldstateBloc>(context),
            builder: (BuildContext context, WorldStates state) {
              if (state is WorldstateUninitialized)
                return const Center(
                  child: CircularProgressIndicator(),
                );

              if (state is WorldstateLoaded) return _mainBody();

              if (state is WorldstateError) return Container();
            },
          )),
      onWillPop: () async {
        if (!scaffold.currentState.isDrawerOpen) {
          scaffold.currentState.openDrawer();
        } else
          Navigator.of(context).pop();

        return false;
      },
    );
  }
}
