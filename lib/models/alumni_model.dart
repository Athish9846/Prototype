import 'package:hive_flutter/adapters.dart';
part 'alumni_model.g.dart';

@HiveType(typeId: 2)
class AlumniModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String batch;

  @HiveField(2)
  final String? company;

  @HiveField(3)
  final String? ctc;

  @HiveField(4)
  final String? count;

  @HiveField(5)
  final String? imageurl;

  @HiveField(6)
  final String? domain;

  @HiveField(7)
  String? id;

  AlumniModel(
      {required this.name,
      required this.batch,
      this.company,
      this.ctc,
      this.count,
      this.imageurl,
      this.domain,
      this.id
      });
}
