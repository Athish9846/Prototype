// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_batch_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddBatchModelAdapter extends TypeAdapter<AddBatchModel> {
  @override
  final int typeId = 3;

  @override
  AddBatchModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddBatchModel(
      batch: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AddBatchModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.batch);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddBatchModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
