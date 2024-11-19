import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:prototype/models/admin_model.dart';

ValueNotifier<List<BatchModel>> batchNotifier = ValueNotifier([]);

Future<void> addBatch(BatchModel value) async {
  value.id = DateTime.now().millisecondsSinceEpoch.toString();

  final admin = await Hive.openBox<BatchModel>('Admin_db');

  await admin.put(value.id, value);

  await getValue();
}

Future<void> getValue() async {
  final admin = await Hive.openBox<BatchModel>('Admin_db');
  batchNotifier.value.clear();
  batchNotifier.value.addAll(admin.values);
  batchNotifier.notifyListeners();
}

Future<void> deleteStudentData(BatchModel value) async {
  final admin = await Hive.openBox<BatchModel>('Admin_db');
  // for (var model in admin.values) {
  //   if (value == model.batch) {
  //     // print('model deleted${model.name}');
  //     await admin.delete(model.id);
  //     print(model.id);
  //   }
  // }
  await admin.delete(value.id);
  await getValue();
}

Future<void> updateValue(BatchModel value) async {
  try {
    final admin = await Hive.openBox<BatchModel>('Admin_db');

    if (admin.containsKey(value.id)) {
      await admin.put(value.id, value);
      log('Updated existing entry with ID: ${value.id}');
    } else {
      log('Entry with ID ${value.id} not found for update.');
    }
  } catch (e) {
    print('Error in Hive update operation: $e');
  }
}
