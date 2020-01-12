import 'package:mockito/mockito.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/repository/api/drop_table_repository.dart';
import 'package:navis/repository/api/worldstate_repository.dart';
import 'package:test/test.dart';
import 'package:warframe_items_model/warframe_items_model.dart';

import '../mock_classes.dart';

void main() {
  WorldstateRepository client;
  DropTableRepository dropTableRepository;

  DropTableSearchBloc drops;
  WarframeItemSearchBloc items;

  setUpAll(() async {
    client = MockWorldstateRepository();
    dropTableRepository = MockDropTableRepository();

    drops = DropTableSearchBloc(dropTableRepository);
    items = WarframeItemSearchBloc(client);
  });

  test('Search the drop table', () {
    when(dropTableRepository.search('chroma'))
        .thenAnswer((_) => Future.value(<SlimDrop>[]));

    expectLater(drops, emitsThrough(const SearchStateSuccess(<SlimDrop>[])));

    drops.add(const TextChanged('chroma'));
  });

  test('Search Warframe items', () {
    when(client.searchItems('chroma'))
        .thenAnswer((_) async => Future.value(<ItemObject>[]));

    expectLater(
      items,
      emitsThrough(const SearchStateSuccess(<ItemObject>[])),
    );

    items.add(const TextChanged('chroma'));
  });
}
