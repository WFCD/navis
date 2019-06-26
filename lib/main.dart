import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:catcher/catcher_plugin.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/services/services.dart';
import 'package:path_provider/path_provider.dart';

import 'app.dart';

Future<void> main() async {
  BlocSupervisor.delegate = await HydratedBlocDelegate.build();

  final debugConfig = CatcherOptions(SilentReportMode(), [ConsoleHandler()]);
  final releaseConfig = CatcherOptions(
      DialogReportMode(), [ConsoleHandler(), FileHandler(await getFile())]);

  await setupLocator();

  Catcher(
    BlocProviderTree(blocProviders: [
      BlocProvider<StorageBloc>(builder: (_) => StorageBloc()),
      BlocProvider<WorldstateBloc>(builder: (_) => WorldstateBloc()),
      BlocProvider<NavigationBloc>(builder: (_) => NavigationBloc())
    ], child: const Navis()),
    debugConfig: debugConfig,
    releaseConfig: releaseConfig,
  );
}

Future<File> getFile() async {
  final directory = await getExternalStorageDirectory();
  return File('${directory.path}/navis/navis_logs.txt');
}
