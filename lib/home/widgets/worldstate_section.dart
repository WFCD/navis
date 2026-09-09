import 'package:material_ui/material_ui.dart';
import 'package:navis/home/widgets/activities_section.dart';
import 'package:navis/home/widgets/news_section.dart';

class WorldstateSection extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(mainAxisSize: MainAxisSize.min, children: [NewsSection(), ActivitiesSection()]);
  }
}
