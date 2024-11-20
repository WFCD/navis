import 'package:flutter/material.dart';
import 'package:navis_ui/navis_ui.dart';

class ExpandableAppCard extends StatefulWidget {
  const ExpandableAppCard({
    super.key,
    required this.header,
    required this.content,
    this.onTap,
  });

  final Widget header;
  final Widget content;

  // ignore: avoid_positional_boolean_parameters
  final void Function(bool isExpanded)? onTap;

  @override
  State<ExpandableAppCard> createState() => _ExpandableAppCardState();
}

class _ExpandableAppCardState extends State<ExpandableAppCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: GestureDetector(
        onTap: () {
          if (mounted) {
            setState(() => _isExpanded = !_isExpanded);
            if (_isExpanded && widget.onTap != null) widget.onTap!(_isExpanded);
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            widget.header,
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: widget.content,
              crossFadeState: _isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: Durations.medium1,
            ),
          ],
        ),
      ),
    );
  }
}
