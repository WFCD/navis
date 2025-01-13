import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/home/widgets/section.dart';
import 'package:navis/profile/profile.dart';
import 'package:navis_ui/navis_ui.dart';

class MasteryInProgressSection extends StatelessWidget {
  const MasteryInProgressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Section(
      title: const Text('Mastery in progress'),
      content: BlocBuilder<ArsenalCubit, ArsenalState>(
        builder: (context, state) {
          const padding = EdgeInsets.symmetric(vertical: 16);

          if (state is ArsenalFailure) {
            return const Padding(
              padding: padding,
              child: Text('Error updating XP info'),
            );
          }

          if (state is! ArsenalSuccess) {
            return const Padding(
              padding: padding,
              child: WarframeSpinner(size: 100),
            );
          }

          return Column(
            children: [
              for (final i in state.xpInfo.take(5))
                ArsenalItemWidget(arsenalItem: i),
            ],
          );
        },
      ),
    );
  }
}
