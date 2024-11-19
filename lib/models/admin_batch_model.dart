import 'package:hive_flutter/adapters.dart';
part 'admin_batch_model.g.dart';
@HiveType(typeId: 3)
class AddBatchModel {

  @HiveField(0)
  String batch;
 
  AddBatchModel({required this.batch});
}
