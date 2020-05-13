import 'package:flutter/material.dart';
import 'package:navis/core/utils/ui_util.dart';

import 'responsive_builder.dart';

class ScreenTypeBuilder extends StatelessWidget {
  const ScreenTypeBuilder({Key key, @required this.mobile, this.tablet})
      : super(key: key);

  // Mobile will be returned by default
  final Widget mobile;
  final Widget tablet;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      // If sizing indicates Tablet and we have a tablet widget then return
      if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
        if (tablet != null) {
          return tablet;
        }
      }

      if (sizingInformation.deviceScreenType == DeviceScreenType.smallTablet) {
        if (tablet != null) {
          switch (MediaQuery.of(context).orientation) {
            case Orientation.portrait:
              return mobile;
            default:
              return tablet;
          }
        }
      }

      // Return mobile layout if nothing else is supplied
      return mobile;
    });
  }
}
