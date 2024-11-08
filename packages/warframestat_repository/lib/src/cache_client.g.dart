// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cache_client.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveCacheItemAdapter extends TypeAdapter<HiveCacheItem> {
  @override
  final int typeId = 0;

  @override
  HiveCacheItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveCacheItem(
      fields[0] as Uint8List,
      fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, HiveCacheItem obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.data)
      ..writeByte(1)
      ..write(obj.expiry);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveCacheItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
