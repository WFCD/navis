import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoria/inventoria.dart';
import 'package:navis/profile/cubit/profile_cubit.dart';
import 'package:navis/settings/settings.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

class BlocBootstrap extends StatelessWidget {
  const BlocBootstrap({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final wsRepo = RepositoryProvider.of<WarframestatRepository>(context);
    final settings = RepositoryProvider.of<UserSettings>(context);
    final inventoria = RepositoryProvider.of<Inventoria>(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => WorldstateCubit(wsRepo)..fetchWorldstate()),
        BlocProvider(create: (_) => UserSettingsCubit(settings)),
        BlocProvider(create: (_) => ProfileCubit(inventoria)..update()),
      ],
      child: child,
    );
  }
}
