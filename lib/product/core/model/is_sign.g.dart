// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'is_sign.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IsSignAdapter extends TypeAdapter<IsSign> {
  @override
  final int typeId = 1;

  @override
  IsSign read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IsSign(
      isSign: fields[0] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, IsSign obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.isSign);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IsSignAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
