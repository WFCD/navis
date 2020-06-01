import 'package:mockito/mockito.dart';
import 'package:navis/services/repository.dart';
import 'package:navis/services/storage/persistent_storage.service.dart';
import 'package:wfcd_client/remotes.dart';

class MockRepository extends Mock implements Repository {}

class MockWarframestatRemote extends Mock implements WarframestatRemote {}

class MockPersistentStorageService extends Mock
    implements PersistentStorageService {}
