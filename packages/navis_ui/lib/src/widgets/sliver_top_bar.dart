import 'dart:math' as math;

import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SliverTopbar extends StatefulWidget {
  const SliverTopbar({
    super.key,
    this.pinned = false,
    this.snap = false,
    this.floating = false,
    required this.child,
  }) : assert(
          floating || !snap,
          'The "snap" argument only makes sense for floating app bars.',
        );

  final bool snap;
  final bool pinned;
  final bool floating;
  final Widget child;

  @override
  SliverTopbarState createState() => SliverTopbarState();
}

class SliverTopbarState extends State<SliverTopbar>
    with TickerProviderStateMixin {
  FloatingHeaderSnapConfiguration? _snapConfiguration;

  void _updateSnapConfiguration() {
    if (widget.snap && widget.floating) {
      _snapConfiguration = FloatingHeaderSnapConfiguration(
        curve: Curves.easeOut,
        duration: kThemeAnimationDuration,
      );
    } else {
      _snapConfiguration = null;
    }
  }

  @override
  void initState() {
    super.initState();

    _updateSnapConfiguration();
  }

  @override
  void didUpdateWidget(SliverTopbar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.snap != oldWidget.snap ||
        widget.floating != oldWidget.floating) {
      _updateSnapConfiguration();
    }
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final collapsedHeight =
        (widget.pinned && widget.floating) ? topPadding : null;

    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      child: SliverPersistentHeader(
        pinned: widget.pinned,
        floating: widget.floating,
        delegate: _SliverTopbarDelegate(
          pinned: widget.pinned,
          floating: widget.floating,
          snapConfiguration: _snapConfiguration,
          topPadding: topPadding,
          collapsedHeight: collapsedHeight,
          vsync: this,
          color: context.theme.brightness.isDark
              ? context.theme.colorScheme.surface
              : context.theme.colorScheme.primary,
          child: widget.child,
        ),
      ),
    );
  }
}

class _FloatingAppBar extends StatefulWidget {
  const _FloatingAppBar({required this.child});

  final Widget child;

  @override
  _FloatingAppBarState createState() => _FloatingAppBarState();
}

// A wrapper for the widget created by _SliverAppBarDelegate that starts and
/// stops the floating appbar's snap-into-view or snap-out-of-view animation.
class _FloatingAppBarState extends State<_FloatingAppBar> {
  ScrollPosition? _position;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_position != null) {
      _position!.isScrollingNotifier.removeListener(_isScrollingListener);
    }

    _position = Scrollable.of(context).position;

    if (_position != null) {
      _position!.isScrollingNotifier.addListener(_isScrollingListener);
    }
  }

  @override
  void dispose() {
    if (_position != null) {
      _position!.isScrollingNotifier.removeListener(_isScrollingListener);
    }

    super.dispose();
  }

  RenderSliverFloatingPersistentHeader? _headerRenderer() {
    return context
        .findAncestorRenderObjectOfType<RenderSliverFloatingPersistentHeader>();
  }

  void _isScrollingListener() {
    if (_position == null) return;

    // When a scroll stops, then maybe snap the appbar into view.
    // Similarly, when a scroll starts, then maybe stop the snap animation.
    final header = _headerRenderer();
    if (_position!.isScrollingNotifier.value) {
      header?.maybeStopSnapAnimation(_position!.userScrollDirection);
    } else {
      header?.maybeStartSnapAnimation(_position!.userScrollDirection);
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

class _SliverTopbarDelegate extends SliverPersistentHeaderDelegate {
  const _SliverTopbarDelegate({
    required this.floating,
    required this.pinned,
    required this.topPadding,
    this.collapsedHeight,
    this.color,
    this.vsync,
    this.snapConfiguration,
    required this.child,
  });

  final bool floating;

  final bool pinned;

  final double topPadding;

  final double? collapsedHeight;

  final Color? color;

  final Widget child;

  @override
  final TickerProvider? vsync;

  @override
  final FloatingHeaderSnapConfiguration? snapConfiguration;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final visibleMainHeight = maxExtent - shrinkOffset;

    // Truth table for `toolbarOpacity`:
    // pinned | floating | bottom != null || opacity
    // ----------------------------------------------
    //    0   |    0     |        0       ||  fade
    //    0   |    0     |        1       ||  fade
    //    0   |    1     |        0       ||  fade
    //    0   |    1     |        1       ||  fade
    //    1   |    0     |        0       ||  1.0
    //    1   |    0     |        1       ||  1.0
    //    1   |    1     |        0       ||  1.0
    //    1   |    1     |        1       ||  fade
    final toolbarOpacity = !pinned || floating
        ? (visibleMainHeight / kTextTabBarHeight).clamp(0.0, 1.0)
        : 1.0;

    final widget = FlexibleSpaceBar.createSettings(
      maxExtent: maxExtent,
      minExtent: minExtent,
      toolbarOpacity: toolbarOpacity,
      currentExtent: math.max(minExtent, maxExtent - shrinkOffset),
      child: Material(
        elevation: 4,
        child: child,
      ),
    );

    return floating ? _FloatingAppBar(child: widget) : widget;
  }

  @override
  double get maxExtent => math.max(topPadding + kTextTabBarHeight, minExtent);

  @override
  double get minExtent => collapsedHeight ?? kTextTabBarHeight;

  @override
  bool shouldRebuild(_SliverTopbarDelegate oldDelegate) {
    return oldDelegate.pinned != pinned ||
        oldDelegate.floating != floating ||
        oldDelegate.collapsedHeight != collapsedHeight ||
        oldDelegate.color != color ||
        oldDelegate.vsync != vsync ||
        oldDelegate.snapConfiguration != snapConfiguration;
  }
}
