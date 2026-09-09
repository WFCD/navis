import 'package:cached_network_image/cached_network_image.dart';
import 'package:material_ui/material_ui.dart';
import 'package:navis/items/utils/mod_utils.dart';

class Polarity extends StatelessWidget {
  const new({super.key, required this.polarity});

  final String polarity;

  @override
  Widget build(BuildContext context) {
    final color = Theme.brightnessOf(context) == .dark ? Colors.white : null;

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
