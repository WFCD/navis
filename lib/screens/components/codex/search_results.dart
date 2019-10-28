import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:warframe_items_model/warframe_items_model.dart';

import 'drop_result.dart';
import 'item_result.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<SearchBloc>(context),
      builder: (BuildContext context, SearchState state) {
        if (state is SearchStateSuccess) {
          final results = state.results ?? [];
          final childCount = results.length;

          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (results is List<SlimDrop>)
                  return DropResultWidget(drop: results[index]);

                return ItemResultWidget(item: results[index]);
              },
              childCount: childCount,
            ),
          );
        }

        return SliverToBoxAdapter(child: Container());
      },
    );
  }
}
