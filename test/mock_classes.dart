import 'package:mockito/mockito.dart';
import 'package:navis/services/repository.dart';
import 'package:navis/services/storage/persistent_storage.service.dart';
import 'package:wfcd_client/clients.dart';

class MockRepository extends Mock implements Repository {}

class MockWfcdWrapper extends Mock implements WorldstateClient {}

class MockPersistentStorageService extends Mock
    implements PersistentStorageService {}
