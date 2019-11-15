import 'package:mockito/mockito.dart';
import 'package:navis/services/repository.dart';
import 'package:navis/services/storage/persistent_storage.service.dart';

class MockRepository extends Mock implements Repository {}

class MockPersistentStorageService extends Mock
    implements PersistentStorageService {}
