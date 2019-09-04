import 'package:flutter/material.dart';
import 'package:navis/utils/utils.dart';
import 'package:warframe_items_model/warframe_items_model.dart';

class DropResultWidget extends StatelessWidget {
  const DropResultWidget({Key key, this.drop}) : super(key: key);

  final SlimDrop drop;

  Color _chance(num chance) {
    if (chance < 25) return Colors.yellow;
    if (chance > 25 && chance < 50) return Colors.white;

    return Colors.brown;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      title: Text(drop.item),
      subtitle: RichText(
        text: TextSpan(children: [
          TextSpan(
            text: parseHtmlString(drop.place),
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
}
