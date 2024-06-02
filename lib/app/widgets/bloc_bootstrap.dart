import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/settings/settings.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

class BlocBootstrap extends StatelessWidget {
  const BlocBootstrap({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final worldstateRepo =
        RepositoryProvider.of<WarframestatRepository>(context);
    final usersettings = RepositoryProvider.of<UserSettings>(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => WorldstateCubit(worldstateRepo)),
        BlocProvider(create: (_) => DarvodealCubit(worldstateRepo)),
        BlocProvider(create: (_) => UserSettingsCubit(usersettings)),
      ],
      child: child,
    );
  }
}
