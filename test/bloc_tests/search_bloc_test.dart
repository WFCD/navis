import 'package:mockito/mockito.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/blocs/search/search_bloc.dart';
import 'package:navis/services/repository.dart';
import 'package:navis/utils/search_utils.dart';
import 'package:test/test.dart';
import 'package:warframe_items_model/warframe_items_model.dart';

import '../mock_classes.dart';
import '../setup_methods.dart';

void main() {
  Repository repository;

  SearchBloc searchBloc;

  setUpAll(() async {
    await mockSetup();

    repository = MockRepository();

    searchBloc = SearchBloc(repository);
  });

  test('Searching the drop table', () {
    when(repository.searchDrops('chroma'))
        .thenAnswer((_) => Future.value(<SlimDrop>[]));

    expectLater(searchBloc,
        emitsThrough(const TypeMatcher<SearchStateSuccess<SlimDrop>>()));

    searchBloc.add(const TextChanged('chroma', type: SearchTypes.drops));
  });

  // test('Searching Warframe items', () {
  //   when(repository.searchItems('chroma'))
  //       .thenAnswer((_) async => Future.value(<ItemObject>[]));

  //   expectLater(
  //     searchBloc,
  //     emitsThrough(const SearchStateSuccess<ItemObject>(<ItemObject>[])),
  //   );

  //   searchBloc.add(const TextChanged('chroma', type: SearchTypes.items));
  // });
}
