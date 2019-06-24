import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/components/layout.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({Key key}) : super(key: key);

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<TableSearchBloc>(context),
      builder: (BuildContext context, SearchState state) {
        final childCount =
            state is SearchStateSuccess ? state.results.length : 0;

        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              if (state is SearchStateSuccess) {
                final item = state.results[index];
                final place = _parseHtmlString(item.place);

                return Tiles(
                  child: ListTile(
                    title: Text(item.item),
                    subtitle: Text('$place | ${item.chance}%'),
                  ),
                );
              }
            },
            childCount: childCount,
          ),
        );
      },
    );
  }
}
