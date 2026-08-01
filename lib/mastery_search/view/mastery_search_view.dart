import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/mastery/mastery.dart';
import 'package:navis/mastery_search/bloc/mastery_search_bloc.dart';

class MasterySearchView extends StatelessWidget {
  const MasterySearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MasterySearchBloc, MasterySearchState>(
      builder: (context, state) => switch (state) {
        MasterySearchSuccessful(:final results) when results.isNotEmpty => ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) => MasteryItemTile(masterableItem: results[index]),
        ),
        MasterySearchSuccessful(:final results) when results.isEmpty => Center(
          child: Text(context.l10n.codexNoResults),
        ),
        _ => const SizedBox.shrink(),
      },
    );
  }
}
