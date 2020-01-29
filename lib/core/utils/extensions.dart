import 'package:wfcd_client/enums.dart';

extension PlatformX on Platforms {
  String platformToString() => toString().split('.').last;
}
