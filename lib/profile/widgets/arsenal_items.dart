import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/profile/cubit/arsenal_cubit.dart';
import 'package:navis/profile/widgets/arsenal_item.dart';
import 'package:navis/settings/settings.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

class ArsenalItems extends StatelessWidget {
  const ArsenalItems({super.key, required this.items});

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
        await BlocProvider.of<ArsenalCubit>(context).syncXpInfo(username);
      },
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) => ArsenalItemWidget(item: items[index]),
      ),
    );
  }
}
