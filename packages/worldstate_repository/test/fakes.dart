import 'package:mocktail/mocktail.dart';
import 'package:wfcd_client/wfcd_client.dart';
import 'package:worldstate_repository/src/request_types.dart';

class FakeWorldstateRequestType extends Fake implements WorldstateRequestType {
  @override
  String get locale => 'en';

  @override
  GamePlatforms get platform => GamePlatforms.pc;
}

class FakeItemSearchRequestType extends Fake implements ItemSearchRequestType {
  @override
  String get locale => 'en';

  @override
  GamePlatforms get platform => GamePlatforms.pc;
}
