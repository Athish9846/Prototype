import 'package:hive_flutter/adapters.dart';

part 'attendence_model.g.dart';

@HiveType(typeId: 4)
class AttendanceModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? date;

  @HiveField(2)
  String? status;

  @HiveField(3)
  final String? name;

  @HiveField(4)
  final String? batch;

  AttendanceModel({
    this.id,
    required this.date,
    required this.status,
    required this.name,
    required this.batch,
  });
}
