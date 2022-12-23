// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PatientProfileAdapter extends TypeAdapter<PatientProfile> {
  @override
  final int typeId = 8;

  @override
  PatientProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PatientProfile(
      id: fields[0] as int?,
      user: fields[1] as User?,
      bio: fields[2] as String?,
      profilePicture: fields[3] as String?,
      idNo: fields[4] as String?,
      nationality: fields[5] as String?,
      town: fields[6] as String?,
      estate: fields[7] as String?,
      gender: fields[8] as String?,
      maritalStatus: fields[9] as String?,
      dateOfBirth: fields[10] as String?,
      timestamp: fields[11] as String?,
      bloodGroup: fields[12] as String?,
      weight: fields[13] as double?,
      height: fields[14] as double?,
      bloodPressure: fields[15] as double?,
      bloodSugar: fields[16] as double?,
      allergies: fields[17] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PatientProfile obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.user)
      ..writeByte(2)
      ..write(obj.bio)
      ..writeByte(3)
      ..write(obj.profilePicture)
      ..writeByte(4)
      ..write(obj.idNo)
      ..writeByte(5)
      ..write(obj.nationality)
      ..writeByte(6)
      ..write(obj.town)
      ..writeByte(7)
      ..write(obj.estate)
      ..writeByte(8)
      ..write(obj.gender)
      ..writeByte(9)
      ..write(obj.maritalStatus)
      ..writeByte(10)
      ..write(obj.dateOfBirth)
      ..writeByte(11)
      ..write(obj.timestamp)
      ..writeByte(12)
      ..write(obj.bloodGroup)
      ..writeByte(13)
      ..write(obj.weight)
      ..writeByte(14)
      ..write(obj.height)
      ..writeByte(15)
      ..write(obj.bloodPressure)
      ..writeByte(16)
      ..write(obj.bloodSugar)
      ..writeByte(17)
      ..write(obj.allergies);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PatientProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 9;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      id: fields[0] as int?,
      fullName: fields[1] as String?,
      email: fields[2] as String?,
      phone: fields[3] as String?,
      role: fields[4] as String?,
      isActive: fields[5] as bool?,
      updatedAt: fields[6] as String?,
      timestamp: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.fullName)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.role)
      ..writeByte(5)
      ..write(obj.isActive)
      ..writeByte(6)
      ..write(obj.updatedAt)
      ..writeByte(7)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
