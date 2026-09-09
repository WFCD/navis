import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';
import 'package:navis/items/widgets/stats/polarity.dart';

class PreinstalledPolarties extends StatelessWidget {
  const new({super.key, required this.polarities});

  final List<String> polarities;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [for (final p in polarities) Polarity(polarity: toBeginningOfSentenceCase(p) ?? '')],
    );
  }
}
