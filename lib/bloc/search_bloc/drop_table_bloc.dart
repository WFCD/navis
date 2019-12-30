import 'package:navis/repository/repositories.dart';
import 'package:warframe_items_model/warframe_items_model.dart';

import 'abstract_search_bloc.dart';

class DropTableSearchBloc extends SearchBloc {
  DropTableSearchBloc(this.dropTableRepository);

  final DropTableRepository dropTableRepository;

  @override
  Future<List<SlimDrop>> search(String term) {
    return dropTableRepository.search(term);
  }
}
