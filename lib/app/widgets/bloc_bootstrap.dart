import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/profile/cubit/profile_cubit.dart';
import 'package:navis/settings/bloc/app_config_bloc.dart';
import 'package:navis_settings/navis_settings.dart';
import 'package:warframe_repository/warframe_repository.dart';

class BlocBootstrap extends StatelessWidget {
  const BlocBootstrap({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final settings = RepositoryProvider.of<SettingsDatabase>(context);
    final warframe = RepositoryProvider.of<WarframeRepository>(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AppConfigBloc(settings)..add(AppConfigSubscriptionRequested())),
        BlocProvider(create: (_) => ProfileCubit(warframe)..refreshProfile()),
      ],
      child: child,
    );
  }
}
