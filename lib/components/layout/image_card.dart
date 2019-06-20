import 'package:flutter/material.dart';

class BackgroundImageCard extends StatelessWidget {
  const BackgroundImageCard(
      {Key key,
      @required this.provider,
      @required this.child,
      this.height,
      this.width,
      this.margin})
      : super(key: key);

  final ImageProvider provider;
  final Widget child;
  final EdgeInsets margin;
  final double height, width;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4,
        margin:
            margin ?? const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        clipBehavior: Clip.hardEdge,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.25), BlendMode.overlay),
            image: provider,
            fit: BoxFit.cover,
          )),
          child: child,
        ));
  }
}
