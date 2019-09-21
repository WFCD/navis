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

  runZoned<Future<void>>(
    () async {
      final repository = await Repository.initRepository();

      BlocSupervisor.delegate = await HydratedBlocDelegate.build();

      runApp(
        MultiBlocProvider(
          providers: [
            BlocProvider<WorldstateBloc>(
              builder: (_) => WorldstateBloc(repository.worldstateService),
            ),
            BlocProvider<NavigationBloc>(
              builder: (_) => NavigationBloc(),
            ),
            BlocProvider<SearchBloc>(
              builder: (_) => SearchBloc(
                  repository.worldstateService, repository.storage.instance),
            )
          ],
          child: Navis(repository),
        ),
      );
    },
    onError: Crashlytics.instance.recordError,
  );
}
