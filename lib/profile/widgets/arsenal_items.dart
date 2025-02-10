import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/profile/cubit/arsenal_cubit.dart';
import 'package:navis/profile/cubit/profile_cubit.dart';
import 'package:navis/profile/widgets/widgets.dart';
import 'package:navis/settings/settings.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

class ArsenalItems extends StatelessWidget {
  const ArsenalItems({super.key, this.controller, required this.items});

  final ScrollController? controller;
  final List<MasteryProgress> items;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        final settings = BlocProvider.of<UserSettingsCubit>(context).state;
        final username = switch (settings) {
          UserSettingsSuccess() => settings.username,
          _ => null
        };

        if (username == null) return;
        await BlocProvider.of<ProfileCubit>(context).update(username);
      },
      child: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          final profile = switch (state) {
            ProfileSuccessful() => state.profile,
            _ => null,
          };

          if (profile == null) return;
          BlocProvider.of<ArsenalCubit>(context).fetchXpInfo();
        },
        child: ListView.builder(
          controller: controller,
          itemCount: items.length,
          itemBuilder: (context, index) =>
              ArsenalItemWidget(progress: items[index]),
        ),
      ),
    );
  }
}
