import 'package:codex/codex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/profile/cubit/profile_cubit.dart';
import 'package:navis/settings/settings.dart';

class BlocBootstrap extends StatelessWidget {
  const BlocBootstrap({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final settings = RepositoryProvider.of<UserSettings>(context);
    final codex = RepositoryProvider.of<Codex>(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UserSettingsCubit(settings)),
        BlocProvider(create: (_) => ProfileCubit(codex)),
      ],
      child: child,
    );
  }
}
