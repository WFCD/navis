import 'package:flutter/material.dart';
import 'package:navis/themes.dart';
import 'package:navis/utils/worldstate_utils.dart';

class SkyboxCard extends StatelessWidget {
  const SkyboxCard({
    Key key,
    @required this.node,
    @required this.child,
    this.height,
    this.width,
    this.margin = const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
    this.alignment = Alignment.center,
    this.elevation = 1.0,
  })  : assert(node != null),
        assert(child != null),
        super(key: key);

  final String node;
  final Widget child;
  final EdgeInsets margin;
  final double height, width, elevation;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.theme.dark,
      child: Card(
        elevation: elevation,
        margin: margin,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        clipBehavior: Clip.hardEdge,
        child: Container(
          height: height,
          width: width,
          alignment: alignment,
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3), BlendMode.dstIn),
              image: skybox(context, node),
              fit: BoxFit.cover,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
