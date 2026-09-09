import 'package:material_ui/material_ui.dart';
import 'package:navis_ui/src/helpers/helpers.dart';
import 'package:warframe_common/warframe_common.dart' show Rarity;

class RewardTile extends StatelessWidget {
  const new({super.key, required this.reward, required this.chance, required this.rarity});

  final String reward;
  final num chance;
  final Rarity rarity;

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    final color = rarity.toColor();

    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(reward, style: textTheme.titleMedium),
          Text('$chance', style: textTheme.bodyMedium?.copyWith(color: color)),
        ],
      ),
      subtitle: LinearProgressIndicator(value: chance / 100, color: color),
    );
  }
}
