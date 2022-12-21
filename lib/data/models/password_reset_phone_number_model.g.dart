// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_reset_phone_number_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PasswordResetPhoneNumberAdapter
    extends TypeAdapter<PasswordResetPhoneNumber> {
  @override
  final int typeId = 4;

  @override
  PasswordResetPhoneNumber read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PasswordResetPhoneNumber(
      data: fields[0] as Data?,
      message: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PasswordResetPhoneNumber obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.data)
      ..writeByte(1)
      ..write(obj.message);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PasswordResetPhoneNumberAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DataAdapter extends TypeAdapter<Data> {
  @override
  final int typeId = 5;

  @override
  Data read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Data(
      phone: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Data obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.phone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
