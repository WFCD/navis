import 'package:flutter/material.dart';
import 'package:navis/utils/theme.dart';
import 'package:navis/utils/skybox.dart';

import 'rounded_card.dart';

class SkyboxCard extends StatelessWidget {
  const SkyboxCard({
    Key key,
    @required this.node,
    @required this.child,
    this.height,
    this.width,
    this.alignment = Alignment.center,
    this.margin = const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
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
    final skybox = SkyBoxLoader(context, node);

    return Theme(
      data: AppTheme.dark,
      child: RoundedCard(
        child: Container(
          height: height,
          width: width,
          alignment: alignment,
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3), BlendMode.dstIn),
              image: skybox.load(),
              fit: BoxFit.cover,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
