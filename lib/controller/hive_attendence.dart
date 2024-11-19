import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:prototype/models/attendence_model.dart';

ValueNotifier<List<AttendanceModel>> attendeanceNotifier = ValueNotifier([]);

// late Box<AttendanceModel> attendanceBox;

Future<void> addAttendences(AttendanceModel value) async {
  try {
    final attendanceBox = await Hive.openBox<AttendanceModel>('attendece_db');
    final id = await attendanceBox.add(value);
    value.id = id;
    await getTodayAttendees();
  } catch (error) {
    print('Error opening Hive box: $error');
  }
}

List<AttendanceModel> hello = [];

Future<void> getTodayAttendees() async {
  final attendanceBox = await Hive.openBox<AttendanceModel>('attendece_db');
  String todayDate = DateTime.now().toString().substring(0, 10);
  // String todayDate = DateFormat.yMd().format(DateTime.now());

  List<AttendanceModel> attendances = attendanceBox.values
      .toList()
      .where((element) =>
          element.date!.length >= 10 &&
          element.date!.substring(0, 10).contains(todayDate))
      .toList();
  // hello = attendanceBox.values.toList();
  // for (var element in hello) {
  //   print(element.date);
  // }

  // List<AttendanceModel> attendances = attendanceBox.values
  //     .toList()
  //     // .where((element) => element.date!.contains(todayDate))
  //     .where((element) =>
  //         element.date != null &&
  //         DateFormat.yMd().format(element.date!).contains(todayDate))
  //     .toList();
  // print(attendances.first.date);
  attendeanceNotifier.value.clear();
  attendeanceNotifier.value.addAll(attendances);
  // attendeanceNotifier.value = attendances;
  attendeanceNotifier.notifyListeners();
}

// Future<void> markAttendance(String Date) async {
//   final attendenceBox = await Hive.openBox<AttendanceModel>('attendece_db');

//   final index = attendenceBox.values
//       .toList()
//       .indexWhere((attendance) => attendance.date == Date);

//   if (index != -1) {
//     AttendanceModel attendance = attendenceBox.getAt(index)!;
//     attendance.status = 'present';
//     await attendenceBox.putAt(index, attendance);
//     await getTodayAttendees();
//   }
// }

Future<void> removeAttendance(String date) async {
  final attendanceBox = await Hive.openBox<AttendanceModel>('attendece_db');

  // Find the attendance instance for the given date
  final index = attendanceBox.values
      .toList()
      .indexWhere((attendance) => attendance.date == date);

  if (index != -1) {
    // Remove the attendance instance from the box
    attendanceBox.deleteAt(index);
  }
  await getTodayAttendees();
}
