import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:navis/injection_container.dart';
import 'package:navis/resources/resources.dart';
import 'package:supercharged/supercharged.dart';

import '../../../../../core/themes/themes.dart';
import '../../../data/datasources/skybox_parser.dart';

class SkyboxCard extends StatelessWidget {
  const SkyboxCard({
    Key key,
    @required this.node,
    @required this.child,
    this.height,
    this.width,
    this.margin = const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
    this.alignment = Alignment.center,
  })  : assert(node != null),
        assert(child != null),
        super(key: key);

  final String node;
  final Widget child;
  final EdgeInsets margin;
  final double height, width;
  final Alignment alignment;

  static const _derelict = AssetImage(Resources.derelictSkybox);

  Widget _imageBuilder(ImageProvider imageProvider) {
    return AnimatedContainer(
      height: height,
      width: width,
      duration: 200.milliseconds,
      alignment: alignment,
      decoration: BoxDecoration(
        image: DecorationImage(
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstIn),
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: NavisTheming.dark,
      child: Card(
        margin: margin,
        child: CachedNetworkImage(
          imageUrl: sl<SkyboxService>().getSkybox(node),
          imageBuilder: (context, imageProvider) =>
              _imageBuilder(imageProvider),
          placeholder: (context, url) => _imageBuilder(_derelict),
          errorWidget: (context, url, dynamic error) =>
              _imageBuilder(_derelict),
        ),
      ),
    );
  }
}
