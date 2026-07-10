import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/items/items.dart';
import 'package:navis/settings/settings.dart';
import 'package:navis/worldstate/worldstate.dart';

class AppStateListener extends StatelessWidget {
  const AppStateListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<WorldstateBloc, WorldState>(
          listener: (context, state) {
            if (state case WorldstateSuccess(:final seed)) {
              context.read<ItemUpdateCubit>().update(seed.buildLabel);
            }
          },
        ),
        BlocListener<SettingsCubit, SettingsState>(
          listener: (context, state) {
            if (state case SettingsSuccess(:final language)) {
              context.read<WorldstateBloc>().add(WorldstateStarted(language));
            }
          },
        ),
      ],
      child: child,
    );
  }
}
