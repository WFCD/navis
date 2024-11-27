import 'package:flutter/material.dart';
import 'package:navis/home/widgets/widgets.dart';
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
    return ListView(
      children: const [NewsSection(), Gaps.gap16, ActivitiesSection()],
    );
  }
}
