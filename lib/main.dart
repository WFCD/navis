import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:catcher/catcher_plugin.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/services/repository.dart';
import 'package:path_provider/path_provider.dart';

import 'app.dart';

Future<File> getFile() async {
  final directory = await getExternalStorageDirectory();
  return File('${directory.path}/Navis/navis_logs.txt');
}

Future<void> main() async {
  final repository = await Repository.initialize();
  final debugConfig = CatcherOptions(SilentReportMode(), [ConsoleHandler()]);
  final releaseConfig = CatcherOptions(
      SilentReportMode(), [ConsoleHandler(), FileHandler(await getFile())]);

  BlocSupervisor.delegate = await HydratedBlocDelegate.build();

  Catcher(
    MultiBlocProvider(providers: [
      BlocProvider<StorageBloc>(builder: (_) => StorageBloc(repository)),
      BlocProvider<WorldstateBloc>(builder: (_) => WorldstateBloc(repository)),
      BlocProvider<NavigationBloc>(builder: (_) => NavigationBloc()),
      BlocProvider<TableSearchBloc>(builder: (_) => TableSearchBloc(repository))
    ], child: Navis(repository)),
    debugConfig: debugConfig,
    releaseConfig: releaseConfig,
  );
}
