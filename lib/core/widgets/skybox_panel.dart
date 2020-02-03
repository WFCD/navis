import 'package:flutter/material.dart';

class SkyboxPanel extends StatelessWidget {
  const SkyboxPanel({
    Key key,
    @required this.node,
    @required this.child,
    this.margin = const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
    this.alignment = Alignment.center,
  })  : assert(node != null),
        assert(child != null),
        super(key: key);

  final String node;
  final EdgeInsets margin;
  final Alignment alignment;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Card(
        margin: margin,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: FutureBuilder<ImageProvider>(
            initialData: const AssetImage('assets/skyboxes/Derelict.webp'),
            // future: skybox(context, node),
            builder: (context, snapshot) {
              return Container(
                alignment: alignment,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.3), BlendMode.dstIn),
                    image: snapshot.data,
                    fit: BoxFit.cover,
                  ),
                ),
                child: child,
              );
            },
          ),
        ),
      ),
    );
  }
}
