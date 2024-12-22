import 'package:drift/drift.dart';
import 'package:warframestat_client/warframestat_client.dart'
    hide ItemTypeConverter;

class ItemTypeConverter extends TypeConverter<ItemType, String>
    with JsonTypeConverter<ItemType, String> {
  const ItemTypeConverter();

  @override
  ItemType fromSql(String fromDb) {
    return ItemType.byType(fromDb);
  }

  @override
  String toSql(ItemType value) {
    return value.type;
  }
}
