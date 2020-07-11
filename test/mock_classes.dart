import 'package:mockito/mockito.dart';
import 'package:navis/services/repository.dart';
import 'package:navis/services/storage/persistent_storage.service.dart';
import 'package:wfcd_client/wfcd_client.dart';

class MockRepository extends Mock implements Repository {}

class MockWarframestatRemote extends Mock implements WarframestatClient {}

class MockPersistentStorageService extends Mock
    implements PersistentStorageService {}
