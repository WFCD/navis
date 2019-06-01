import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/components/layout.dart';
import 'package:navis/components/styles.dart';
import 'package:navis/utils/enums.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 250), value: 1.0, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
      controller: _controller,
      title: const Text('Navis'),
      actions: const <Widget>[
        PlatformIcon(platform: Platforms.pc),
        PlatformIcon(platform: Platforms.ps4),
        PlatformIcon(platform: Platforms.xb1),
        PlatformIcon(platform: Platforms.swi)
      ],
      backLayer: Backlayer(controller: _controller),
      frontLayer: Center(
        child: BlocBuilder<RouteEvent, RouteState>(
          bloc: BlocProvider.of<NavigationBloc>(context),
          builder: (BuildContext context, RouteState route) => route.widget,
        ),
      ),
    );
  }
}
