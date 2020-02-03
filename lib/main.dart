import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/injection_container.dart';

import 'core/app.dart';
import 'core/bloc/navigation_bloc.dart';
import 'features/worldstate/presentation/bloc/solsystem_bloc.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = await HydratedBlocDelegate.build();

  await di.init();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => sl<NavigationBloc>()),
      BlocProvider(create: (_) => sl<SolsystemBloc>())
    ],
    child: const NavisApp(),
  ));
}
