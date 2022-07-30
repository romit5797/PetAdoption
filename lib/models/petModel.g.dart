// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'petModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PetModelAdapter extends TypeAdapter<PetModel> {
  @override
  final int typeId = 0;

  @override
  PetModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PetModel(
      id: fields[0] as String,
      name: fields[1] as String,
      adopted: fields[2] as bool,
      location: fields[3] as String,
      description: fields[4] as String,
      attributes: (fields[5] as List).cast<String>(),
      type: fields[6] as String,
      price: fields[7] as num,
      breed: fields[8] as String,
      images: (fields[9] as List).cast<String>(),
      gender: fields[10] as String,
      age: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PetModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.adopted)
      ..writeByte(3)
      ..write(obj.location)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.attributes)
      ..writeByte(6)
      ..write(obj.type)
      ..writeByte(7)
      ..write(obj.price)
      ..writeByte(8)
      ..write(obj.breed)
      ..writeByte(9)
      ..write(obj.images)
      ..writeByte(10)
      ..write(obj.gender)
      ..writeByte(11)
      ..write(obj.age);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PetModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
