// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solar_notification_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SolarNotificationModelAdapter
    extends TypeAdapter<SolarNotificationModel> {
  @override
  final int typeId = 2;

  @override
  SolarNotificationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SolarNotificationModel(
      messageType: fields[0] as String,
      messageID: fields[1] as String,
      messageURL: fields[2] as String,
      messageIssueTime: fields[3] as String,
      messageBody: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SolarNotificationModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.messageType)
      ..writeByte(1)
      ..write(obj.messageID)
      ..writeByte(2)
      ..write(obj.messageURL)
      ..writeByte(3)
      ..write(obj.messageIssueTime)
      ..writeByte(4)
      ..write(obj.messageBody);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SolarNotificationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
