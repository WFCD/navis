import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/profile/profile.dart';

class PlayerProgress extends StatefulWidget {
  const PlayerProgress({super.key});

  @override
  State<PlayerProgress> createState() => _PlayerProgressState();
}

class _PlayerProgressState extends State<PlayerProgress> {
  void calculateProgress() {
    final state = BlocProvider.of<ProfileCubit>(context).state;

    if (state is ProfileSuccesful) {
      final profile = state.profile;
      final info = (
        rank: profile.masteryRank,
        items: profile.loadout.xpInfo,
        missions: profile.missions
      );

      BlocProvider.of<MasteryCalCubit>(context).calculateMastery(info);
    }
  }

  @override
  void initState() {
    super.initState();

    calculateProgress();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (previous, next) {
        if (next is ProfileSuccesful) {
          final profile = next.profile;
          final info = (
            rank: profile.masteryRank,
            items: profile.loadout.xpInfo,
            missions: profile.missions
          );

          BlocProvider.of<MasteryCalCubit>(context).calculateMastery(info);
        }
      },
      child: BlocBuilder<MasteryCalCubit, MasteryCalState>(
        builder: (context, state) {
          double? progress;
          if (state is MasteryCalculated) {
            progress = state.requiredForNext / (state.next - state.owned);
          }

          return LinearProgressIndicator(value: progress);
        },
      ),
    );
  }
}
