import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:navis/codex/widgets/codex_entry/polarity.dart';

class PreinstalledPolarties extends StatelessWidget {
  const PreinstalledPolarties({super.key, required this.polarities});

  final List<String> polarities;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        for (final p in polarities)
          Polarity(polarity: toBeginningOfSentenceCase(p) ?? ''),
      ],
    );
  }
}
