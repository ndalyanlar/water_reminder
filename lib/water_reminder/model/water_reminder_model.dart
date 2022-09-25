import 'package:hive/hive.dart';
part 'water_reminder_model.g.dart';

@HiveType(typeId: 1)
class WaterReminderModel {
  WaterReminderModel({
    required this.value,
    required this.target,
    required this.beginTime,
    required this.endTime,
    required this.selectedHour,
  });

  @HiveField(0)
  double value = 0;

  @HiveField(1)
  String? selectedHour;

  @HiveField(2)
  DateTime beginTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 12);

  @HiveField(3)
  DateTime endTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 18);

  @HiveField(4, defaultValue: "1500")
  late String target;

  copyWith({
    double? value,
    String? selectedHour,
    DateTime? beginTime,
    DateTime? endTime,
    String? target,
  }) {
    return WaterReminderModel(
      value: value ?? this.value,
      selectedHour: selectedHour ?? this.selectedHour,
      beginTime: beginTime ?? this.beginTime,
      endTime: endTime ?? this.endTime,
      target: target ?? this.target,
    );
  }
}
