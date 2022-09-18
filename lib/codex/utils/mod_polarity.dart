// These are helper functions are are gonna be rebuilt every time a user goes
// to another mod regardles.
// ignore_for_file: avoid-returning-widgets

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';

Image loadModPart(String partName) {
  final partUrl = Uri.parse(
    'https://raw.githubusercontent.com/WFCD/genesis-assets/master/modFrames/$partName',
  );

  return Image(
    image: CachedNetworkImageProvider(partUrl.toString()),
  );
}

Image getPolarity(String polarity, {Color? color}) {
  final polarityUrl = Uri.parse(
    'https://raw.githubusercontent.com/WFCD/genesis-assets/master/emoji/${polarity.toLowerCase()}.png',
  );

  return Image(
    color: color,
    colorBlendMode: BlendMode.srcIn,
    image: CachedNetworkImageProvider(polarityUrl.toString()),
  );
}
