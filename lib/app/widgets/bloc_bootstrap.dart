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
  late UserSettingsCubit _userSettingsCubit;
  // late ProfileCubit _profileCubit;

  @override
  void initState() {
    super.initState();

    final wsRepo = RepositoryProvider.of<WarframestatRepository>(context);
    final settings = RepositoryProvider.of<UserSettings>(context);

    _worldstateCubit = WorldstateCubit(wsRepo);
    _userSettingsCubit = UserSettingsCubit(settings);
    // _profileCubit = ProfileCubit(wsRepo);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _worldstateCubit.fetchWorldstate();

    // final state = _userSettingsCubit.state;
    // final username = switch (state) {
    //   UserSettingsSuccess() => state.username,
    //   _ => null,
    // };

    // if (username != null) {
    //   _profileCubit.update(username);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _worldstateCubit),
        BlocProvider.value(value: _userSettingsCubit),
        // BlocProvider.value(value: _profileCubit),
      ],
      child: widget.child,
    );
  }
}
