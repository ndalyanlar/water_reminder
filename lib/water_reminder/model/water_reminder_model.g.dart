// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'water_reminder_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WaterReminderModelAdapter extends TypeAdapter<WaterReminderModel> {
  @override
  final int typeId = 1;

  @override
  WaterReminderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WaterReminderModel(
      value: fields[0] as double,
      target: fields[4] == null ? '1500' : fields[4] as String,
      beginTime: fields[2] as DateTime,
      endTime: fields[3] as DateTime,
      selectedHour: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, WaterReminderModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.value)
      ..writeByte(1)
      ..write(obj.selectedHour)
      ..writeByte(2)
      ..write(obj.beginTime)
      ..writeByte(3)
      ..write(obj.endTime)
      ..writeByte(4)
      ..write(obj.target);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WaterReminderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
