import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:codex/codex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/profile/profile.dart';
import 'package:warframe_icons/warframe_icons.dart';

class ArsenalItems extends StatelessWidget {
  const ArsenalItems({super.key, this.controller, required this.items});

  final ScrollController? controller;
  final List<CodexItem> items;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => BlocProvider.of<ProfileCubit>(context).refreshProfile(),
      child: items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(WarframeIcons.menuWoundedInfestedPredator, size: 200),
                  Text(
                    'Nothing to see here',
                    style: context.textTheme.titleLarge,
                  ),
                ],
              ),
            )
          : ListView.builder(
              controller: controller,
              itemCount: items.length,
              itemBuilder: (context, index) => ArsenalItemWidget(item: items[index]),
            ),
    );
  }
}
