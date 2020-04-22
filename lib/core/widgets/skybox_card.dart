import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:navis/core/themes/themes.dart';

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

  static const derelict = AssetImage('assets/Derelict.webp');

  String getBackgroundPath(String node) {
    const base =
        'https://raw.githubusercontent.com/WFCD/navis/master/assets/skyboxes';
    final nodeRegExp = RegExp(r'\(([^)]*)\)');
    final nodeBackground = nodeRegExp.firstMatch(node)?.group(1);

    return '$base/${Intl.getCurrentLocale() ?? 'en'}/${nodeBackground.replaceAll(' ', '_')}.webp';
  }

  Widget _imageBuilder(
      BuildContext context, ImageProvider<dynamic> imageProvider) {
    return Container(
      height: height,
      width: width,
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

  Widget _placeHolder(BuildContext context, String string) {
    return _imageBuilder(context, derelict);
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(derelict, context);

    return Theme(
      data: NavisTheming.dark,
      child: Card(
        margin: margin,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: CachedNetworkImage(
            imageUrl: getBackgroundPath(node),
            placeholder: _placeHolder,
            errorWidget: (BuildContext context, String string, Object object) {
              return _placeHolder(context, string);
            },
            imageBuilder: _imageBuilder,
          ),
        ),
      ),
    );
  }
}
