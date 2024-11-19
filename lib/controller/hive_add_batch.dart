import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:prototype/models/admin_batch_model.dart';


ValueNotifier<List<AddBatchModel>> batches = ValueNotifier([]);
// ValueNotifier<List<AddBatchModel>>([]);

Future<void> addbatches(AddBatchModel values) async {
  final studentBatches = await Hive.openBox<AddBatchModel>('batches_db');
  await studentBatches.add(values);
  // batches.value.add(values);
  // // batches.value = studentBatches.values.toList();
  // batches.notifyListeners();
  await getBatches();
}

Future<void> getBatches() async {
  final studentBatches = await Hive.openBox<AddBatchModel>('batches_db');
  batches.value.clear();
  batches.value.addAll(studentBatches.values);

  // batches.value = studentBatches.values.toList();
  batches.notifyListeners();
}

Future<void> deleteValue(AddBatchModel values) async {
  final studentBatches = await Hive.openBox<AddBatchModel>('batches_db');
  final index =
      studentBatches.values.toList().indexWhere((element) => element.batch == values.batch);
  // await deleteBatch(values.batch);
  await studentBatches.deleteAt(index);
  batches.value.remove(values);
  batches.notifyListeners();
  await getBatches();
}
