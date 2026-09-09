import 'package:material_ui/material_ui.dart';
import 'package:navis_ui/navis_ui.dart';

class SkyboxCard extends StatelessWidget {
  const new({
    super.key,
    required this.node,
    this.margin = const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
    this.padding = const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
    this.height = 150,
    required this.child,
  });

  final String node;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Theme(
        data: theme.copyWith(
          textTheme: Typography.whiteMountainView,
          iconTheme: theme.iconTheme.copyWith(color: Colors.white),
        ),
        child: BackgroundImage(
          imageUrl: getSkybox(node),
          alignment: Alignment.center,
          height: height,
          child: SizedBox(
            height: height,
            child: Padding(
              padding: padding,
              child: Center(child: child),
            ),
          ),
        ),
      ),
    );
  }
}
