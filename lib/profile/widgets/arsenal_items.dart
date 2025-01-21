import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoria/inventoria.dart';
import 'package:navis/profile/cubit/arsenal_cubit.dart';
import 'package:navis/profile/cubit/profile_cubit.dart';
import 'package:navis/profile/widgets/widgets.dart';

class ArsenalItems extends StatelessWidget {
  const ArsenalItems({super.key, this.controller, required this.items});

  final ScrollController? controller;
  final List<InventoryItemData> items;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => BlocProvider.of<ProfileCubit>(context).update(),
      child: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          final profile = switch (state) {
            ProfileSuccessful() => state.profile,
            _ => null,
          };

          if (profile == null) return;
          BlocProvider.of<ArsenalCubit>(context)
              .syncXpInfo(profile.loadout.xpInfo);
        },
        child: ListView.builder(
          controller: controller,
          itemCount: items.length,
          itemBuilder: (context, index) => ArsenalItemWidget(item: items[index]),
        ),
      ),
    );
  }
}
