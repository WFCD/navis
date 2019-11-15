import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/screens/codex.dart';
import 'package:navis/screens/fissures.dart';
import 'package:navis/screens/home.dart';
import 'package:navis/screens/invasions.dart';
import 'package:navis/screens/sortie.dart';
import 'package:navis/screens/syndicates.dart';

class ScaffoldBody extends StatelessWidget {
  const ScaffoldBody({Key key}) : super(key: key);

  Widget _body(RouteState route) {
    switch (route) {
      case RouteState.fissures:
        return const FissureScreen();
      case RouteState.invasions:
        return const InvasionsScreen();
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
    return BlocBuilder<NavigationBloc, RouteState>(
      builder: (BuildContext context, RouteState route) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: _body(route),
        );
      },
    );
  }
}
