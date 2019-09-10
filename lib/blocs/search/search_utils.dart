import 'dart:convert';

import 'package:warframe_items_model/warframe_items_model.dart';

enum Sort { unsorted, a_b, high_low, low_high }

enum SearchTypes { drops, items }

List<SlimDrop> convertToDrop(String data) {
  final table = json.decode(data);

  if (table is Map<String, dynamic>) {
    return [];
  }

  return table.map<SlimDrop>((d) => SlimDrop.fromJson(d)).toList();
}

List<SlimDrop> sortDrops(SortedDrops dropInstance) {
  final sortBy = dropInstance.sortBy;
  final drops = dropInstance.drops;

  switch (sortBy) {
    case Sort.a_b:
      return drops..sort((a, b) => a.item.compareTo(b.item));
    case Sort.high_low:
      return drops..sort((a, b) => b.chance.compareTo(a.chance));
    case Sort.low_high:
      return drops..sort((a, b) => a.chance.compareTo(b.chance));
    default:
      return drops..shuffle();
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
