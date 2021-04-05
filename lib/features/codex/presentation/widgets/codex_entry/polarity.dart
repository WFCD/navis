import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../core/utils/extensions.dart';
import '../../../utils/mod_polarity.dart';

class Polarity extends StatelessWidget {
  const Polarity({Key? key, required this.polarity}) : super(key: key);

  final String polarity;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).isDark;

    return Image.asset(
      getPolarity(polarity),
      width: 20,
      color: isDark ? null : Colors.black,
    );
  }
}

class PreinstalledPolarties extends StatelessWidget {
  const PreinstalledPolarties({Key? key, required this.polarities})
      : super(key: key);

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
