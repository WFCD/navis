import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/blocs/search/search_bloc.dart';
import 'package:navis/blocs/search/search_utils.dart';
import 'package:navis/services/worldstate_service.dart';
import 'package:test/test.dart';
import 'package:warframe_items_model/warframe_items_model.dart';

import '../setup_methods.dart';

class MockWorldstateService extends Mock implements WorldstateService {}

void main() {
  final dropTable = File('./drop_table.json');

  WorldstateService api;

  SearchBloc searchBloc;
  List<SlimDrop> localTable;

  setUpAll(() async {
    await mockSetup();

    api = MockWorldstateService();
    searchBloc = SearchBloc(api, await Hive.openBox('test'));

    localTable = json
        .decode(dropTable.readAsStringSync())
        .cast<Map<String, dynamic>>()
        .map<SlimDrop>((d) => SlimDrop.fromJson(d))
        .toList();
  });

  test('Make sure the drop table are loaded correctly', () async {
    when(api.initializeDropTable())
        .thenAnswer((_) async => Future.value(dropTable));

    await searchBloc.loadDropTable();

    expectLater(listEquals(searchBloc.dropTable, localTable), true);
  });

  test('Searching the drop table', () async {
    searchBloc.add(const TextChanged('chroma', type: SearchTypes.drops));

    await Future.delayed(const Duration(milliseconds: 900));

    expectLater(searchBloc.state, const TypeMatcher<SearchStateSuccess>());
  });

  test('Searching Warframe items', () async {
    when(api.search('chroma')).thenAnswer((_) => Future.value(<ItemObject>[]));

    searchBloc.add(const TextChanged('chroma', type: SearchTypes.items));

    await Future.delayed(const Duration(milliseconds: 900));

    expectLater(searchBloc.state, const TypeMatcher<SearchStateSuccess>());
  });
}
