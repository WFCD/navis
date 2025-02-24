import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:navis/l10n/l10n.dart';

class Section extends StatelessWidget {
  const Section({super.key, required this.title, required this.content, this.onTap});

  final Widget title;
  final Widget content;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          textColor: context.theme.colorScheme.secondary,
          title: title,
          trailing: TextButton(onPressed: onTap, child: Text(context.l10n.seeMore)),
        ),
        content,
      ],
    );
  }
}
