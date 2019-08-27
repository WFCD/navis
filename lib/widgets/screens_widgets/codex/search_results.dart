import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:navis/blocs/bloc.dart';

import 'package:navis/utils/utils.dart';
import 'package:warframe_items_model/warframe_items_model.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({Key key}) : super(key: key);

  Color _chance(num chance) {
    if (chance < 25) return Colors.yellow;
    if (chance > 25 && chance < 50) return Colors.white;

    return Colors.brown;
  }

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    return parse(document.body.text).documentElement.text;
  }

  Widget _itemResult(BuildContext context, ItemObject item) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
      child: ListTile(
        title: Text(item.name),
        subtitle: Text(_parseHtmlString(item.description ?? '')),
        dense: true,
        isThreeLine: true,
        onTap: () => launchLink(context, item?.wikiaUrl),
      ),
    );
  }

  Widget _dropResult(BuildContext context, SlimDrop drop) {
    final theme = Theme.of(context);

    return ListTile(
      title: Text(drop.item),
      subtitle: RichText(
        text: TextSpan(children: [
          TextSpan(
            text: _parseHtmlString(drop.place),
            style: theme.textTheme.caption,
          ),
          const TextSpan(text: ' | '),
          TextSpan(
            text: '${drop.chance}% Drop Chance',
            style: theme.textTheme.caption.copyWith(
              color: _chance(drop.chance),
            ),
          ),
        ]),
      ),
      dense: true,
    );
  }

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
                  return _dropResult(context, results[index]);

                return _itemResult(context, results[index]);
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
