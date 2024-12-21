import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/home/home.dart';
import 'package:navis/settings/settings.dart';
import 'package:navis_ui/navis_ui.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeView();
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserSettingsCubit, UserSettingsState>(
      builder: (context, state) {
        final username = switch (state) {
          UserSettingsSuccess() => state.username,
          _ => null
        };

        final children = [
          const NewsSection(),
          const ActivitiesSection(),
          if (username != null) const MasteryInProgressSection(),
        ];

        return ListView.separated(
          itemCount: children.length,
          separatorBuilder: (_, __) => Gaps.gap16,
          itemBuilder: (context, index) => children[index],
        );
      },
    );
  }
}
