import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ItemImage extends StatelessWidget {
  const ItemImage({Key key, @required this.imageName, this.height = 100})
      : super(key: key);

  final String imageName;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(4.0),
      clipBehavior: Clip.hardEdge,
      child: CachedNetworkImage(
        imageUrl: 'https://cdn.warframestat.us/img/$imageName',
        fit: BoxFit.cover,
        width: (1.5 * height) / 2,
        height: height,
      ),
    );
  }
}
