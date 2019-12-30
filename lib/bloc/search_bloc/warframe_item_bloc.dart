import 'package:navis/repository/repositories.dart';
import 'package:warframe_items_model/warframe_items_model.dart';

import 'abstract_search_bloc.dart';

class WarframeItemSearchBloc extends SearchBloc {
  WarframeItemSearchBloc(this.worldstateRepository);

  final WorldstateRepository worldstateRepository;

  @override
  Future<List<ItemObject>> search(String term) {
    return worldstateRepository.searchItems(term);
  }
}
