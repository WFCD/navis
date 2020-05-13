import 'package:flutter/widgets.dart';

enum DeviceScreenType { mobile, smallTablet, tablet }

class SizingInformation {
  const SizingInformation({
    @required this.deviceScreenType,
    @required this.screenSize,
    @required this.localWidgetSize,
  });

  factory SizingInformation.fromConstraints(
      MediaQueryData mediaQuery, BoxConstraints constraints) {
    return SizingInformation(
      deviceScreenType: mediaQuery.getDeviceType(),
      screenSize: mediaQuery.size,
      localWidgetSize: Size(constraints.maxWidth, constraints.maxHeight),
    );
  }

  final DeviceScreenType deviceScreenType;
  final Size screenSize;
  final Size localWidgetSize;
}

extension on MediaQueryData {
  DeviceScreenType getDeviceType() {
    final deviceWidth = size.shortestSide;

    if (deviceWidth >= 640 && deviceWidth <= 960) {
      return DeviceScreenType.smallTablet;
    } else if (deviceWidth >= 960) {
      return DeviceScreenType.tablet;
    } else {
      return DeviceScreenType.mobile;
    }
  }
}
