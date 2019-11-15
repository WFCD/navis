import 'package:mockito/mockito.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/blocs/search/search_bloc.dart';
import 'package:navis/services/repository.dart';
import 'package:test/test.dart';
import 'package:warframe_items_model/warframe_items_model.dart';

import '../mock_classes.dart';
import '../setup_methods.dart';

void main() {
  // final dropTable = File('./drop_table.json');

  Repository repository;

  SearchBloc searchBloc;
  // List<SlimDrop> localTable;

  setUpAll(() async {
    await mockSetup();

    repository = MockRepository();

    searchBloc = SearchBloc(repository);

    // localTable = json
    //     .decode(dropTable.readAsStringSync())
    //     .cast<Map<String, dynamic>>()
    //     .map<SlimDrop>((d) => SlimDrop.fromJson(d))
    //     .toList();
  });

  // test('Make sure the drop table are loaded correctly', () async {
  //   when(repository.search('chroma'))
  //       .thenAnswer((_) async => Future.value(<SlimDrop>[]));

  //   await searchBloc.loadDropTable();

  //   expectLater(listEquals(searchBloc._dropTable, localTable), true);
  // });

  test('Searching the drop table', () async {
    expectLater(
        searchBloc, emitsThrough(const TypeMatcher<SearchStateSuccess>()));

    searchBloc.add(const TextChanged('chroma'));
  });

  test('Test search type change', () {});

  test('Searching Warframe items', () async {
    expectLater(
        searchBloc, emitsThrough(const TypeMatcher<SearchStateSuccess>()));

    when(repository.search('chroma'))
        .thenAnswer((_) async => Future.value(<ItemObject>[]));

    searchBloc.add(const TextChanged('chroma'));
  });
}
