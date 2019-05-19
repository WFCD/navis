import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/services/service_locator.dart';

import 'app.dart';

Future<void> main() async {
  await setupLocator();
  runApp(BlocProviderTree(blocProviders: [
    BlocProvider<StorageBloc>(bloc: StorageBloc()),
    BlocProvider<WorldstateBloc>(bloc: WorldstateBloc()),
    BlocProvider<ThemeBloc>(bloc: ThemeBloc()),
    BlocProvider<NavigationBloc>(bloc: NavigationBloc())
  ], child: const Navis()));
}
