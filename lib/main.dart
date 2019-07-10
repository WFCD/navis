import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:catcher/catcher_plugin.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/services/services.dart';
import 'package:path_provider/path_provider.dart';

import 'app.dart';

Future<File> getFile() async {
  final directory = await getExternalStorageDirectory();
  return File('${directory.path}/Navis/navis_logs.txt');
}

Future<void> main() async {
  await setupLocator();

  BlocSupervisor.delegate = await HydratedBlocDelegate.build();

  final debugConfig = CatcherOptions(SilentReportMode(), [ConsoleHandler()]);
  final releaseConfig = CatcherOptions(
      SilentReportMode(), [ConsoleHandler(), FileHandler(await getFile())]);

  Catcher(
    MultiBlocProvider(providers: [
      BlocProvider<StorageBloc>(builder: (_) => StorageBloc()),
      BlocProvider<WorldstateBloc>(builder: (_) => WorldstateBloc()),
      BlocProvider<NavigationBloc>(builder: (_) => NavigationBloc()),
      BlocProvider<TableSearchBloc>(builder: (_) => TableSearchBloc())
    ], child: const Navis()),
    debugConfig: debugConfig,
    releaseConfig: releaseConfig,
  );
}
