// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timertile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimerTileAdapter extends TypeAdapter<TimerTile> {
  @override
  final int typeId = 0;

  @override
  TimerTile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TimerTile()
      ..title = fields[0] as String
      ..subtitle = fields[1] as String
      ..timerOnetitle = fields[2] as String
      ..timeOneTo = fields[3] as DateTime
      ..timerTwotitle = fields[4] as String
      ..timeTwoTo = fields[5] as DateTime
      ..timerThreetitle = fields[6] as String
      ..timeThreeTo = fields[7] as DateTime;
  }

  @override
  void write(BinaryWriter writer, TimerTile obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.subtitle)
      ..writeByte(2)
      ..write(obj.timerOnetitle)
      ..writeByte(3)
      ..write(obj.timeOneTo)
      ..writeByte(4)
      ..write(obj.timerTwotitle)
      ..writeByte(5)
      ..write(obj.timeTwoTo)
      ..writeByte(6)
      ..write(obj.timerThreetitle)
      ..writeByte(7)
      ..write(obj.timeThreeTo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimerTileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
