import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/global_keys.dart';
import 'package:navis/services/repository.dart';
import 'package:navis/widgets/drawer/drawer.dart';
import 'package:navis/widgets/scaffold/scaffold_body.dart';
import 'package:navis/widgets/scaffold/scaffold_listener.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key key}) : super(key: key);

  Future<bool> _willPop(BuildContext context) async {
    final Box box =
        RepositoryProvider.of<Repository>(context).persistent.hiveBox;

    if (box.get('backkey', defaultValue: false)) {
      if (!appScaffold.currentState.isDrawerOpen) {
        appScaffold.currentState.openDrawer();
        return false;
      } else
        return true;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _willPop(context),
      child: Scaffold(
        key: appScaffold,
        appBar: AppBar(),
        drawer: const LotusDrawer(),
        body: const ScaffoldListenerWidget(
          child: ScaffoldBody(),
        ),
      ),
    );
  }
}
