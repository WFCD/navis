import 'package:codex/codex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/profile/profile.dart';

class ArsenalItems extends StatelessWidget {
  const ArsenalItems({super.key, this.controller, required this.items});

  final ScrollController? controller;
  final List<CodexItem> items;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => BlocProvider.of<ProfileCubit>(context).syncProfile(),
      child: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          final profile = switch (state) {
            ProfileSuccessful() => state.profile,
            _ => null,
          };

          if (profile == null) return;
          BlocProvider.of<MasteryProgressCubit>(context).syncXpInfo();
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
