import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:navis/services/localstorage_service.dart';
import 'package:navis/services/notification_service.dart';
import 'package:navis/services/worldstate_service.dart';

class MockClient extends Mock implements Client {}

class MockWorldstateService extends Mock implements WorldstateService {}

class MockLocalStrorageService extends Mock implements LocalStorageService {}

class MockNotificationService extends Mock implements NotificationService {}
