import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:navis/components/layout.dart';
import 'package:navis/models/drop_tables/slim.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({Key key, this.rewards}) : super(key: key);

  final List<Reward> rewards;

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: rewards.length,
      itemBuilder: (BuildContext context, int index) {
        final item = rewards[index];
        final place = _parseHtmlString(item.place);

        return Tiles(
          child: ListTile(
            title: Text(item.item),
            subtitle: Text('$place | ${item.chance}%'),
          ),
        );
      },
    );
  }
}
