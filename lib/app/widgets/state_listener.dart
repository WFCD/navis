import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/items/items.dart';
import 'package:navis/settings/settings.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:warframe_drop_repository/warframe_drop_repository.dart';

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
              context.read<WarframeDropRepository>().buildDrops(seed.buildLabel);
            }
          },
        ),
        BlocListener<SettingsCubit, SettingsState>(
          listener: (context, state) {
            final locale = state.language.languageCode;
            if (locale != context.read<WorldstateBloc>().locale) {
              context.read<WorldstateBloc>().add(WorldstateStarted(locale));
            }
          },
        ),
      ],
      child: child,
    );
  }
}
