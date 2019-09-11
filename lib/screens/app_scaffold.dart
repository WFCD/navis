import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/blocs/worldstate/worldstate_events.dart';
import 'package:navis/global_keys.dart';
import 'package:navis/widgets/widgets.dart';

import 'codex.dart';
import 'fissures.dart';
import 'home.dart';
import 'invasions.dart';
import 'sortie.dart';
import 'syndicates.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(minutes: 5), (t) {
      BlocProvider.of<WorldstateBloc>(context).dispatch(UpdateEvent());
    });

    super.initState();
  }

  Future<bool> _willPop(BuildContext context) async {
    if (!scaffold.currentState.isDrawerOpen) {
      scaffold.currentState.openDrawer();
      return Future.value(false);
    } else
      return Future.value(true);
  }

  void showSnackbar(String content, [VoidCallback onPressed]) {
    scaffold.currentState.showSnackBar(
      SnackBar(
        content: Text(content),
        duration: const Duration(minutes: 5),
        action: onPressed != null
            ? SnackBarAction(
                label: 'RETRY',
                onPressed: onPressed,
              )
            : null,
      ),
    );
  }

  void _blocListener<T>(BuildContext context, T state,
      [VoidCallback onPressed]) {
    if (state is WorldstateError) showSnackbar(state.error, onPressed);
    if (state is SearchListenerError) showSnackbar(state.error);
  }

  Widget _body(RouteState route) {
    switch (route) {
      case RouteState.fissures:
        return const FissureList();
      case RouteState.invasions:
        return const InvasionsList();
      case RouteState.sortie:
        return const SortieScreen();
      case RouteState.syndicates:
        return SyndicatesList();
      case RouteState.droptable:
        return const Codex();
      default:
        return const Home();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _willPop(context),
      child: Scaffold(
        key: scaffold,
        appBar: AppBar(title: const Text('Navis')),
        drawer: const LotusDrawer(),
        body: MultiBlocListener(
          listeners: [
            BlocListener<WorldstateBloc, WorldStates>(
              listener: (context, state) => _blocListener(
                context,
                state,
                () async {
                  await BlocProvider.of<WorldstateBloc>(context).update();
                },
              ),
            ),
            BlocListener<SearchBloc, SearchState>(
              listener: (context, state) => _blocListener(context, state),
            )
          ],
          child: BlocBuilder<NavigationBloc, RouteState>(
            builder: (BuildContext context, RouteState route) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: _body(route),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
