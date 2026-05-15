import 'package:flutter/material.dart';

const _toggleHeight = 40.0;

typedef Segment = ({String label, Widget child});

class SliverSegmentedBar extends SliverPersistentHeaderDelegate {
  SliverSegmentedBar({required this.children, required this.onChange});

  final List<Segment> children;
  final void Function(int) onChange;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final colorScheme = Theme.of(context).colorScheme;
    final background = colorScheme.surface;
    final surface = colorScheme.surfaceTint;

    return Material(
      color: Color.lerp(
        background,
        Color.alphaBlend(surface.withValues(alpha: .08), background),
        !overlapsContent ? 1.0 : 0.0,
      ),
      child: SizedBox(
        height: maxExtent,
        child: SegmentedBar(children: children, onChange: onChange),
      ),
    );
  }

  @override
  double get maxExtent => _toggleHeight;

  @override
  double get minExtent => _toggleHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class SegmentedBar extends StatefulWidget {
  const SegmentedBar({super.key, required this.children, required this.onChange});

  final List<Segment> children;
  final void Function(int) onChange;

  @override
  State<SegmentedBar> createState() => _SegmentedBarState();
}

class _SegmentedBarState extends State<SegmentedBar> {
  static const _toggleHeight = 40.0;
  final _borderRadius = BorderRadius.circular(_toggleHeight);

  int _currentIndex = 0;
  late Segment _currentSegment = widget.children[_currentIndex];

  Widget _segment(Segment segment, double width, ThemeData theme) {
    final colorScheme = theme.colorScheme;
    final textStyle = theme.textTheme.labelLarge!.copyWith(
      color: segment == _currentSegment ? colorScheme.onSecondaryContainer : colorScheme.onSurface,
    );

    return DefaultTextStyle(
      style: textStyle,
      child: Tooltip(
        message: segment.label,
        child: InkWell(
          onTap: () {
            if (!mounted) return;
            setState(() {
              _currentIndex = widget.children.indexOf(segment);
              _currentSegment = segment;
            });
            widget.onChange(_currentIndex);
          },
          borderRadius: _borderRadius,
          child: SizedBox(
            width: width,
            height: _toggleHeight,
            child: Center(child: segment.child),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Material(
        type: MaterialType.button,
        color: theme.colorScheme.surfaceContainerLow,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: theme.colorScheme.secondaryContainer),
          borderRadius: _borderRadius,
        ),
        clipBehavior: Clip.antiAlias,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final length = widget.children.length;
            final segmentWidth = constraints.maxWidth / length;

            return Stack(
              children: [
                AnimatedPositioned(
                  duration: Durations.medium1,
                  curve: Curves.easeOut,
                  left: (constraints.maxWidth / length) * _currentIndex,
                  child: Material(
                    elevation: 8,
                    color: theme.colorScheme.secondaryContainer,
                    borderRadius: _borderRadius,
                    child: SizedBox(width: segmentWidth, height: _toggleHeight),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.children.map((t) => Expanded(child: _segment(t, segmentWidth, theme))).toList(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
