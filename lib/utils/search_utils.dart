import 'package:warframe_items_model/warframe_items_model.dart';

enum Sort { unsorted, a_b, high_low, low_high }

enum SearchTypes { drops, items }

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

class SortedDrops {
  SortedDrops(this.sortBy, this.drops);

  final Sort sortBy;
  final List<SlimDrop> drops;
}
