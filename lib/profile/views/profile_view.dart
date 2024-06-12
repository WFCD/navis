import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/profile/profile.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = RepositoryProvider.of<WarframestatRepository>(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              ProfileCubit(repository)..fetchProfile('OrnsteinTheSlayer'),
        ),
        BlocProvider(
          create: (_) => MasteryCalCubit(repository),
        ),
      ],
      child: const ProfileView(),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading || state is ProfileInitial) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ProfileFailure) return Center(child: Text(state.message));

        final profile = (state as ProfileSuccesful).profile;

        return ListView(
          children: [
            PlayerCard(
              username: profile.username,
              masteryRank: profile.masteryRank,
            ),
            DailyStandingCard(
              rank: profile.masteryRank,
              dailyStanding: profile.dailyStanding,
            ),
          ],
        );
      },
    );
  }
}
