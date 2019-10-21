import 'package:flutter/material.dart';
import 'package:navis/themes.dart';

class BackgroundImageCard extends StatelessWidget {
  const BackgroundImageCard({
    Key key,
    @required this.provider,
    @required this.child,
    this.height,
    this.width,
    this.margin = const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
    this.alignment = Alignment.center,
    this.elevation = 1.0,
  }) : super(key: key);

  final ImageProvider provider;
  final Widget child;
  final EdgeInsets margin;
  final double height, width;
  final Alignment alignment;
  final double elevation;

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
              image: provider,
              fit: BoxFit.cover,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
