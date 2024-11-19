// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BatchModelAdapter extends TypeAdapter<BatchModel> {
  @override
  final int typeId = 1;

  @override
  BatchModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BatchModel(
      name: fields[0] as String,
      batch: fields[1] as String,
      domain: fields[2] as String?,
      week: fields[3] as String,
      score: fields[4] as String,
      id: fields[5] as String?,
      image: fields[6] as String?,
      email: fields[7] as String?,
      hub: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BatchModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.batch)
      ..writeByte(2)
      ..write(obj.domain)
      ..writeByte(3)
      ..write(obj.week)
      ..writeByte(4)
      ..write(obj.score)
      ..writeByte(5)
      ..write(obj.id)
      ..writeByte(6)
      ..write(obj.image)
      ..writeByte(7)
      ..write(obj.email)
      ..writeByte(8)
      ..write(obj.hub);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BatchModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
