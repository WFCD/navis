import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:mockito/mockito.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/blocs/search/search_bloc.dart';
import 'package:navis/blocs/search/search_utils.dart';
import 'package:navis/services/wfcd_api/drop_table_api.service.dart';
import 'package:navis/services/wfcd_api/worldstate_api.service.dart';
import 'package:test/test.dart';
import 'package:warframe_items_model/warframe_items_model.dart';

import '../mock_classes.dart';
import '../setup_methods.dart';

void main() {
  final dropTable = File('./drop_table.json');

  WorldstateApiService worldstateApiService;
  DropTableApiService dropTableApiService;

  SearchBloc searchBloc;
  List<SlimDrop> localTable;

  setUpAll(() async {
    await mockSetup();

    worldstateApiService = MockWorldstateApiService();
    dropTableApiService = MockDropTableApiService();

    searchBloc = SearchBloc(worldstateApiService, dropTableApiService);

    localTable = json
        .decode(dropTable.readAsStringSync())
        .cast<Map<String, dynamic>>()
        .map<SlimDrop>((d) => SlimDrop.fromJson(d))
        .toList();
  });

  test('Make sure the drop table are loaded correctly', () async {
    when(dropTableApiService.dropTable)
        .thenAnswer((_) async => Future.value(dropTable));

    await searchBloc.loadDropTable();

    expectLater(listEquals(searchBloc.dropTable, localTable), true);
  });

  test('Searching the drop table', () async {
    expectLater(
        searchBloc, emitsThrough(const TypeMatcher<SearchStateSuccess>()));

    searchBloc.add(const TextChanged('chroma', type: SearchTypes.drops));
  });

  test('Searching Warframe items', () async {
    expectLater(
        searchBloc, emitsThrough(const TypeMatcher<SearchStateSuccess>()));

    when(worldstateApiService.search('chroma'))
        .thenAnswer((_) async => Future.value(<ItemObject>[]));

    searchBloc.add(const TextChanged('chroma', type: SearchTypes.items));
  });
}
