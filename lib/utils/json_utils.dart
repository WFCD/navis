import 'dart:convert';

import 'package:warframe_items_model/warframe_items_model.dart';

class JsonToObjects {
  static List<SlimDrop> convertToDrop(String data) {
    final table = json.decode(data);

    if (table is Map<String, dynamic>) return [];

    return table.map<SlimDrop>((d) => SlimDrop.fromJson(d)).toList();
  }
}
