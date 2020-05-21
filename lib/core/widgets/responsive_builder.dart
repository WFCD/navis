import 'package:flutter/material.dart';
import 'package:navis/core/utils/ui_util.dart';

typedef SizeBuilder = Widget Function(
    BuildContext context, SizingInformation sizingInformation);

class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({this.builder});

  final SizeBuilder builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final sizingInformation = SizingInformation.fromConstraints(
            MediaQuery.of(context), constraints);

        return builder(context, sizingInformation);
      },
    );
  }
}
