import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/home/widgets/activities_section.dart';
import 'package:navis/home/widgets/news_section.dart';
import 'package:navis/worldstate/bloc/worldstate_bloc.dart';
import 'package:warframe_repository/warframe_repository.dart';

class WorldstateSection extends StatelessWidget {
  const WorldstateSection({super.key});

  @override
  Widget build(BuildContext context) {
    final wsRepo = RepositoryProvider.of<WarframeRepository>(context);

    return BlocProvider(
      create: (_) => WorldstateBloc(wsRepo),
      child: const Column(mainAxisSize: MainAxisSize.min, children: [NewsSection(), ActivitiesSection()]),
    );
  }
}
