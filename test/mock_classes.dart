import 'package:mockito/mockito.dart';
import 'package:navis/services/storage/persistent_storage.service.dart';
import 'package:navis/services/wfcd_api/drop_table_api.service.dart';
import 'package:navis/services/wfcd_api/worldstate_api.service.dart';

class MockWorldstateApiService extends Mock implements WorldstateApiService {}

class MockDropTableApiService extends Mock implements DropTableApiService {}

class MockPersistentStorageService extends Mock
    implements PersistentStorageService {}
