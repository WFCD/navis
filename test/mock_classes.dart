import 'package:mockito/mockito.dart';
import 'package:navis/services/repository.dart';
import 'package:navis/services/storage/persistent_storage.service.dart';
import 'package:wfcd_api_wrapper/wfcd_wrapper.dart';

class MockRepository extends Mock implements Repository {}

class MockWfcdWrapper extends Mock implements WfcdWrapper {}

class MockPersistentStorageService extends Mock
    implements PersistentStorageService {}
