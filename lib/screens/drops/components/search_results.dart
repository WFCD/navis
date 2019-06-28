import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/models/drop_tables/slim.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({Key key}) : super(key: key);

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    return parse(document.body.text).documentElement.text;
  }

  Color _chance(num chance) {
    if (chance < 25) return Colors.yellow;
    if (chance > 25 && chance < 50) return const Color(0xFFc0c0c0);

    return Colors.brown;
  }

  Widget _result(BuildContext context, Reward drop) {
    final theme = Theme.of(context);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
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
      ),
    );
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
                return _result(context, state.results[index]);
              }
            },
            childCount: childCount,
          ),
        );
      },
    );
  }
}
