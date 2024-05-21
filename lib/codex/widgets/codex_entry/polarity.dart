import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:navis/codex/codex.dart';

class Polarity extends StatelessWidget {
  const Polarity({super.key, required this.polarity});

  final String polarity;

  @override
  Widget build(BuildContext context) {
    final color = context.theme.isDark ? Colors.white : null;

    return SizedBox(
      width: 20,
      child: Image(
        color: color,
        colorBlendMode: BlendMode.srcIn,
        image: CachedNetworkImageProvider(polarityUrl(polarity)),
      ),
    );
  }
}
