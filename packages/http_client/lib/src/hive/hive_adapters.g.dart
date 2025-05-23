// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class CachedItemAdapter extends TypeAdapter<CachedItem> {
  @override
  final int typeId = 0;

  @override
  CachedItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CachedItem(
      data: fields[0] as Uint8List,
      timestamp: fields[1] as DateTime,
      ttl: fields[2] == null ? const Duration(seconds: 60) : fields[2] as Duration,
    );
  }

  @override
  void write(BinaryWriter writer, CachedItem obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.data)
      ..writeByte(1)
      ..write(obj.timestamp)
      ..writeByte(2)
      ..write(obj.ttl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CachedItemAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
