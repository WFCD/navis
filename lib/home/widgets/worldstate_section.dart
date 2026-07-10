import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/home/widgets/activities_section.dart';
import 'package:navis/home/widgets/news_section.dart';
import 'package:navis/worldstate/bloc/worldstate_bloc.dart';
import 'package:worldstate_repository/worldstate_repository.dart';

class WorldstateSection extends StatelessWidget {
  const WorldstateSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WorldstateBloc(context.locale.languageCode, context.read<WorldstateRepository>()),
      child: const Column(mainAxisSize: MainAxisSize.min, children: [NewsSection(), ActivitiesSection()]),
    );
  }
}
