import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/app.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/services/repository.dart';

void main() {
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  runZoned<Future<void>>(() async {
    final repository = await Repository.initialize();

    BlocSupervisor.delegate = await HydratedBlocDelegate.build();

    runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<StorageBloc>(builder: (_) => StorageBloc(repository)),
          BlocProvider<WorldstateBloc>(
              builder: (_) => WorldstateBloc(repository)),
          BlocProvider<NavigationBloc>(builder: (_) => NavigationBloc()),
          BlocProvider<TableSearchBloc>(
              builder: (_) => TableSearchBloc(repository))
        ],
        child: Navis(repository),
      ),
    );
  }, onError: Crashlytics.instance.recordError);
}
