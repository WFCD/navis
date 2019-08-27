import 'dart:convert';

import 'package:warframe_items_model/warframe_items_model.dart';

import 'search_event.dart';

List<SlimDrop> convertToDrop(String data) {
  final List<dynamic> table = json.decode(data);

  return table.map((d) => SlimDrop.fromJson(d)).toList();
}

List<SlimDrop> sortDrops(SortedDrops dropInstance) {
  final sortBy = dropInstance.sortBy;
  final drops = dropInstance.drops;

  switch (sortBy) {
    case Sort.ab:
      return drops..sort((a, b) => a.item.compareTo(b.item));
    case Sort.hl:
      return drops..sort((a, b) => b.chance.compareTo(a.chance));
    default:
      return drops..sort((a, b) => a.chance.compareTo(b.chance));
  }
}

List<SlimDrop> searchDropTable(SearchDropTable searchInstance) {
  final searchTerm = searchInstance.searchTerm.toLowerCase();

  return searchInstance.table
      .where((i) => i.item.toLowerCase().contains(searchTerm))
      .toList();
}

class SearchDropTable {
  SearchDropTable(this.searchTerm, this.table);

  final String searchTerm;
  final List<SlimDrop> table;
}

class SortedDrops {
  SortedDrops(this.sortBy, this.drops);

  final Sort sortBy;
  final List<SlimDrop> drops;
}
