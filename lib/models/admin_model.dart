import 'package:hive/hive.dart';
part 'admin_model.g.dart';

@HiveType(typeId: 1)
class BatchModel {
  
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String batch;

  @HiveField(2)
  final String? domain;

  @HiveField(3)
  String week;

  @HiveField(4)
  String score;

  @HiveField(5)
  String? id;

  @HiveField(6)
  final String? image;

  @HiveField(7)
  final String? email;

  @HiveField(8)
  final String? hub;

  BatchModel(
      {required this.name,
      required this.batch,
      required this.domain,
      required this.week,
      required this.score,
      this.id,
      this.image,
      required this.email,
      required this.hub});
}
