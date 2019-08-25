import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/models/slim_drop_table.dart';
import 'package:navis/utils/utils.dart';
import 'package:warframe_items_model/warframe_items_model.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({Key key}) : super(key: key);

  Color _chance(num chance) {
    if (chance < 25) return Colors.yellow;
    if (chance > 25 && chance < 50) return const Color(0xFFc0c0c0);

    return Colors.brown;
  }

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    return parse(document.body.text).documentElement.text;
  }

  Widget _result(BuildContext context, BasicItem item) {
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

  Widget _dropResult(BuildContext context, Drop drop) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(drop.item, style: theme.textTheme.subhead),
          const SizedBox(height: 4),
          Text('${drop.chance}% Drop Chance',
              style: theme.textTheme.caption
                  .copyWith(color: _chance(drop.chance))),
          const SizedBox(height: 4),
          Text(_parseHtmlString(drop.place))
        ],
      ),
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
                if (results is List<Drop>)
                  return _dropResult(context, results[index]);

                return _result(context, results[index]);
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
