import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../themes/colors.dart';

class SliverTopbar extends StatefulWidget {
  const SliverTopbar({
    Key key,
    this.pinned = false,
    this.snap = false,
    this.floating = false,
    this.child,
  })  : assert(floating != null),
        assert(pinned != null),
        assert(snap != null),
        assert(floating || !snap,
            'The "snap" argument only makes sense for floating app bars.'),
        super(key: key);

  final bool snap;
  final bool pinned;
  final bool floating;
  final Widget child;

  @override
  _SliverTopbarState createState() => _SliverTopbarState();
}

class _SliverTopbarState extends State<SliverTopbar>
    with TickerProviderStateMixin {
  FloatingHeaderSnapConfiguration _snapConfiguration;

  void _updateSnapConfiguration() {
    if (widget.snap && widget.floating) {
      _snapConfiguration = FloatingHeaderSnapConfiguration(
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 200),
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
    final double topPadding = MediaQuery.of(context).padding.top ?? 0.0;
    final double collapsedHeight =
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
          child: widget.child,
        ),
      ),
    );
  }
}

class _FloatingAppBar extends StatefulWidget {
  const _FloatingAppBar({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  _FloatingAppBarState createState() => _FloatingAppBarState();
}

// A wrapper for the widget created by _SliverAppBarDelegate that starts and
/// stops the floating appbar's snap-into-view or snap-out-of-view animation.
class _FloatingAppBarState extends State<_FloatingAppBar> {
  ScrollPosition _position;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_position != null) {
      _position.isScrollingNotifier.removeListener(_isScrollingListener);
    }

    _position = Scrollable.of(context)?.position;

    if (_position != null) {
      _position.isScrollingNotifier.addListener(_isScrollingListener);
    }
  }

  @override
  void dispose() {
    if (_position != null) {
      _position.isScrollingNotifier.removeListener(_isScrollingListener);
    }

    super.dispose();
  }

  RenderSliverFloatingPersistentHeader _headerRenderer() {
    return context
        .findAncestorRenderObjectOfType<RenderSliverFloatingPersistentHeader>();
  }

  void _isScrollingListener() {
    if (_position == null) return;

    // When a scroll stops, then maybe snap the appbar into view.
    // Similarly, when a scroll starts, then maybe stop the snap animation.
    final RenderSliverFloatingPersistentHeader header = _headerRenderer();
    if (_position.isScrollingNotifier.value) {
      header?.maybeStopSnapAnimation(_position.userScrollDirection);
    } else {
      header?.maybeStartSnapAnimation(_position.userScrollDirection);
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

class _SliverTopbarDelegate extends SliverPersistentHeaderDelegate {
  const _SliverTopbarDelegate({
    this.floating,
    this.pinned,
    this.topPadding,
    this.collapsedHeight,
    this.snapConfiguration,
    this.vsync,
    this.child,
  });

  final bool floating;
  final bool pinned;
  final double topPadding;
  final double collapsedHeight;

  final Widget child;

  @override
  final TickerProvider vsync;

  @override
  final FloatingHeaderSnapConfiguration snapConfiguration;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final double visibleMainHeight = maxExtent - shrinkOffset;

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
    final double toolbarOpacity = !pinned || floating
        ? (visibleMainHeight / kTextTabBarHeight).clamp(0.0, 1.0).toDouble()
        : 1.0;

    final widget = FlexibleSpaceBar.createSettings(
      maxExtent: maxExtent,
      minExtent: minExtent,
      toolbarOpacity: toolbarOpacity,
      currentExtent: math.max(minExtent, maxExtent - shrinkOffset),
      child: Material(
        color: primary,
        elevation: 4.0,
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
        oldDelegate.snapConfiguration != snapConfiguration;
  }
}
