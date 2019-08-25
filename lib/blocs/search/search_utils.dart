import 'dart:convert';

import 'package:navis/models/slim_drop_table.dart';

import 'search_event.dart';

List<Drop> convertToDrop(String data) {
  final List<dynamic> table = json.decode(data);

  return table.map((d) => Drop.fromJson(d)).toList();
}

List<Drop> sortDrops(SortedDrops dropInstance) {
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

List<Drop> searchDropTable(SearchDropTable searchInstance) {
  final searchTerm = searchInstance.searchTerm.toLowerCase();

  return searchInstance.table
      .where((i) => i.item.toLowerCase().contains(searchTerm))
      .toList();
}

class SearchDropTable {
  SearchDropTable(this.searchTerm, this.table);

  final String searchTerm;
  final List<Drop> table;
}

class SortedDrops {
  SortedDrops(this.sortBy, this.drops);

  final Sort sortBy;
  final List<Drop> drops;
}
