// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'neo_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NeoModelAdapter extends TypeAdapter<NeoModel> {
  @override
  final int typeId = 1;

  @override
  NeoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NeoModel(
      id: fields[0] as String,
      name: fields[1] as String,
      absoluteMagnitude: fields[2] as String,
      isHazardous: fields[3] as bool,
      closeApproachDate: fields[4] as String,
      missDistanceKm: fields[5] as String,
      diameterMaxKm: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NeoModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.absoluteMagnitude)
      ..writeByte(3)
      ..write(obj.isHazardous)
      ..writeByte(4)
      ..write(obj.closeApproachDate)
      ..writeByte(5)
      ..write(obj.missDistanceKm)
      ..writeByte(6)
      ..write(obj.diameterMaxKm);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NeoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
