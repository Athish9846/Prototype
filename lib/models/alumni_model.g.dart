// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alumni_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AlumniModelAdapter extends TypeAdapter<AlumniModel> {
  @override
  final int typeId = 2;

  @override
  AlumniModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AlumniModel(
      name: fields[0] as String,
      batch: fields[1] as String,
      company: fields[2] as String?,
      ctc: fields[3] as String?,
      count: fields[4] as String?,
      imageurl: fields[5] as String?,
      domain: fields[6] as String?,
      id: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AlumniModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.batch)
      ..writeByte(2)
      ..write(obj.company)
      ..writeByte(3)
      ..write(obj.ctc)
      ..writeByte(4)
      ..write(obj.count)
      ..writeByte(5)
      ..write(obj.imageurl)
      ..writeByte(6)
      ..write(obj.domain)
      ..writeByte(7)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlumniModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
