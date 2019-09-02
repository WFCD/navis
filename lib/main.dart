import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/app.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/router.dart';
import 'package:navis/services/repository.dart';
import 'package:navis/utils/metric_client.dart';

void main() {
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  runZoned<Future<void>>(
    () async {
      final repository = Repository(MetricHttpClient(http.Client()));

      BlocSupervisor.delegate = await HydratedBlocDelegate.build();

      await repository.initRepository();

      defineRoutes(router);

      runApp(
        MultiBlocProvider(
          providers: [
            BlocProvider<StorageBloc>(
              builder: (_) =>
                  StorageBloc(repository.storage, repository.notifications),
            ),
            BlocProvider<WorldstateBloc>(
              builder: (_) => WorldstateBloc(repository.worldstateService),
            ),
            BlocProvider<NavigationBloc>(
              builder: (_) => NavigationBloc(),
            ),
            BlocProvider<SearchBloc>(
              builder: (_) => SearchBloc(repository.worldstateService),
            )
          ],
          child: Navis(repository),
        ),
      );
    },
    onError: Crashlytics.instance.recordError,
  );
}
