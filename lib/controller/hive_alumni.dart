import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:prototype/models/alumni_model.dart';

ValueNotifier<List<AlumniModel>> alumniNotifier = ValueNotifier([]);

Future<void> addAlumni(AlumniModel value) async {
  value.id = DateTime.now().millisecondsSinceEpoch.toString();
  final alumni = await Hive.openBox<AlumniModel>('Alumni_db');

  await alumni.put(value.id, value);
  getAlumni();
}

Future<void> getAlumni() async {
  final alumni = await Hive.openBox<AlumniModel>('Alumni_db');
  alumniNotifier.value.clear();
  alumniNotifier.value.addAll(alumni.values);
  alumniNotifier.notifyListeners();
}

Future<void> deleteAlumni(AlumniModel value) async {
  final alumni = await Hive.openBox<AlumniModel>('Alumni_db');
  alumni.delete(value.id);
  await getAlumni();
}
