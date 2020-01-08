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

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.theme.dark,
      child: Card(
        margin: margin,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: FutureBuilder<ImageProvider>(
            initialData: const AssetImage('assets/skyboxes/Derelict.webp'),
            future: skybox(context, node),
            builder: (context, snapshot) {
              return Container(
                height: height,
                width: width,
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
