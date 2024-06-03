import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/settings/settings.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

class BlocBootstrap extends StatefulWidget {
  const BlocBootstrap({super.key, required this.child});

  final Widget child;

  @override
  State<BlocBootstrap> createState() => _BlocBootstrapState();
}

class _BlocBootstrapState extends State<BlocBootstrap> {
  late WorldstateCubit _worldstateCubit;
  late DarvodealCubit _darvodealCubit;
  late UserSettingsCubit _userSettingsCubit;

  @override
  void initState() {
    super.initState();

    final worldstateRepo =
        RepositoryProvider.of<WarframestatRepository>(context);
    final usersettings = RepositoryProvider.of<UserSettings>(context);

    _worldstateCubit = WorldstateCubit(worldstateRepo);
    _darvodealCubit = DarvodealCubit(worldstateRepo);
    _userSettingsCubit = UserSettingsCubit(usersettings);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _worldstateCubit),
        BlocProvider.value(value: _darvodealCubit),
        BlocProvider.value(value: _userSettingsCubit),
      ],
      child: widget.child,
    );
  }
}
