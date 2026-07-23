import 'package:flutter/material.dart';
import 'package:navis/home/widgets/activities_section.dart';
import 'package:navis/home/widgets/news_section.dart';

class WorldstateSection extends StatelessWidget {
  const WorldstateSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(mainAxisSize: MainAxisSize.min, children: [NewsSection(), ActivitiesSection()]);
  }
}
