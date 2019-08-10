import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/components/widgets.dart';
import 'package:navis/global_keys.dart';
import 'package:navis/screens/drops/drops_list.dart';
import 'package:navis/screens/feed/feed.dart';
import 'package:navis/screens/fissures/fissures.dart';
import 'package:navis/screens/invasions/invasions.dart';
import 'package:navis/screens/sortie/sortie.dart';
import 'package:navis/screens/syndicates/syndicates.dart';
import 'package:navis/services/repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  Timer timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    RepositoryProvider.of<Repository>(context).notificationService.configure;

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

  Future<bool> _willPop(BuildContext context) async {
    if (!scaffold.currentState.isDrawerOpen) {
      scaffold.currentState.openDrawer();
      return Future.value(false);
    } else
      return Future.value(true);
  }

  void _blocListener(
    BuildContext context,
    WorldStates state,
    VoidCallback onPressed,
  ) {
    if (state is WorldstateError)
      scaffold.currentState.showSnackBar(SnackBar(
        content: Text(state.error),
        duration: const Duration(minutes: 5),
        action: SnackBarAction(
          label: 'RETRY',
          onPressed: onPressed,
        ),
      ));
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
        return const DropTableList();
      default:
        return const Feed();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<WorldstateBloc>(context);

    return WillPopScope(
      onWillPop: () => _willPop(context),
      child: Scaffold(
        key: scaffold,
        appBar: AppBar(title: const Text('Navis')),
        drawer: const LotusDrawer(),
        body: BlocListener(
          bloc: bloc,
          listener: (BuildContext context, WorldStates state) => _blocListener(
            context,
            state,
            () => bloc.dispatch(UpdateEvent.update),
          ),
          child: BlocBuilder<NavigationBloc, RouteState>(
            bloc: BlocProvider.of<NavigationBloc>(context),
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
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
