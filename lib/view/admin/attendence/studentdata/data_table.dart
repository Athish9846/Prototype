import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:prototype/components/app_bar.dart';
import 'package:prototype/controller/hive_attendence.dart';
import 'package:prototype/controller/hive_batch.dart';
import 'package:prototype/models/admin_model.dart';
import 'package:prototype/models/attendence_model.dart';
import 'package:prototype/view/admin/attendence/studentdata/cell_attendance.dart';
import 'package:prototype/view/admin/dashboard/report/reports.dart';
import 'package:prototype/view/admin/dashboard/show_profile.dart';

class StudentData extends StatefulWidget {
  String batches;

  StudentData({super.key, required this.batches});

  @override
  State<StudentData> createState() => _StudentDataState();
}

class _StudentDataState extends State<StudentData> {
  final _searchController = TextEditingController();
  final columns = ['No', 'NAME', 'DOMAIN', 'ATTENDANCE'];
  int? sortColumnIndex;
  bool isAscending = false;
  List<BatchModel> adminList = [];
  List<BatchModel> tempList = [];
  List<AttendanceModel> studentAttendance = [];
  Uint8List? generatedPdfBytes;

  @override
  void initState() {
    sortedBatch();
    super.initState();
  }

  void sortedBatch() async {
    await getValue();
    adminList = batchNotifier.value;
    if (widget.batches != '') {
      for (var model in batchNotifier.value) {
        if (model.batch == widget.batches) {
          tempList.add(model);
        }
      }
      setState(() {
        adminList = tempList;
      });
    }
  }

  String query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(116),
        child: Column(
          children: [
            MyAppBar(
              iconThemeData: const IconThemeData(color: Colors.red),
              automaticallyImplyLeading: true,
              appbartitle: 'STUDENTS DATA',
            ),
            Container(
              height: 60,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      query = value;
                    });
                  },
                  style: const TextStyle(fontSize: 20),
                  controller: _searchController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: const EdgeInsets.only(bottom: 10),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: batchNotifier,
              builder:
                  (BuildContext ctx, List<BatchModel> list, Widget? child) {
                final sortedList = list
                    .where(
                      (element) =>
                          element.name
                              .toLowerCase()
                              .contains(query.toLowerCase()) ||
                          element.domain!
                              .toLowerCase()
                              .contains(query.toLowerCase()),
                    )
                    .toList();
                return Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          color: Colors.black,
                          child: const Center(
                            child: Text(
                              'Status > > >  On Going Students',
                              style: TextStyle(color: Colors.red, fontSize: 20),
                            ),
                          ),
                        ),
                        buildDataTable(sortedList),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      // floating Action Buttton
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          generatedPdfBytes = generatedPdfBytes;
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (ctx) => Report(
                      // selectedStudent: selectedStudent,
                      attendance: adminList,
                      presentStudents: studentAttendance,
                    )),
            (route) => route.isFirst,
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildDataTable(List<BatchModel> adminList) {
    double screenWidth = MediaQuery.of(context).size.width;
    double columnSpacingFraction = 0.10;
    return DataTable(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
      ),
      sortColumnIndex: sortColumnIndex,
      sortAscending: isAscending,
      border: TableBorder.all(width: 0.1),
      dataTextStyle: const TextStyle(fontSize: 13, color: Colors.black),
      columnSpacing: screenWidth * columnSpacingFraction,
      headingRowColor: MaterialStatePropertyAll(Colors.grey.shade800),
      columns: buildDataColumns(),
      rows: buildDataRows(adminList, context),
    );
  }

  List<DataColumn> buildDataColumns() {
    return columns.asMap().entries.map((entry) {
      final dataindex = entry.key;
      final col = entry.value;
      return DataColumn(
        label: Text(
          col,
          style: const TextStyle(color: Colors.white70),
        ),
        onSort: col == 'ATTENDANCE'
            ? null
            : (columnIndex, ascending) =>
                onSort(columnIndex, ascending, dataindex),
      );
    }).toList();
  }

  List<DataRow> buildDataRows(
      List<BatchModel> adminList, BuildContext context) {
    adminList.sort((a, b) {
      int aBatch = int.tryParse(a.batch) ?? 0;
      int bBatch = int.tryParse(b.batch) ?? 0;

      return aBatch - bBatch;
    });

    return List.generate(adminList.length, (index) {
      final data = adminList[index];

      return DataRow(
        onLongPress: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => ShowProfile(studentData: adminList[index])));
        },
        cells: [
          DataCell(Text('${index + 1}', softWrap: true)),
          DataCell(Text(data.name.toUpperCase(), softWrap: true)),
          DataCell(Text(data.domain!, softWrap: true)),
          DataCell(AttendanceCell(
            student: data,
            studentAttendence: studentAttendance.toList(),
            onAddTap: (isPresent) {
              setState(() {
                addAttendence(data, isPresent, index);
              });
            },
          )),
        ],
      );
    });
  }

  void onSort(int columnIndex, bool ascending, int dataIndex) {
    adminList.sort((user1, user2) {
      switch (columnIndex) {
        case 0:
          return compareString(ascending, user1.name, user2.name);
        case 1:
          return compareString(ascending, user1.domain!, user2.domain!);
        // case 2:
        //   return compareString(ascending, user1.domain!, user2.domain!);
        // case 3:
        //   return compareString(ascending, user1.week, user2.week);
        // case 4:
        //   return compareString(ascending, user1.score, user2.score);
        default:
          return 0;
      }
    });

    setState(() {
      sortColumnIndex = columnIndex;
      isAscending = ascending;
    });
  }

  int compareString(bool ascending, String value1, String value2) {
    return ascending ? value1.compareTo(value2) : value2.compareTo(value1);
  }

  Future<void> addAttendence(
      BatchModel student, bool isPresent, int index) async {
    // bool isPresent = studentAttendance.contains(student);
    isPresent = !isPresent;

    // if (index < 0 || index >= widget.presentStudents!.length) {
    //   return;
    // }
    // bool alreadyPresent = studentAttendance.any((attendance) =>
    //     attendance.name == student.name && attendance.batch == student.batch);
    if (isPresent
        // && alreadyPresent
        ) {
      AttendanceModel attendance = AttendanceModel(
          date: DateTime.now().toLocal().toString().substring(0, 10),
          name: student.name,
          batch: student.batch,
          // status: isPresent ? 'present' : 'absent',
          status: 'present');
      studentAttendance.add(attendance);
      await addAttendences(attendance);
      print(DateTime.now().toLocal().toString().substring(0, 10));
      // final attendenceBox = await Hive.openBox<AttendanceModel>('attendece_db');

      // print('add attendance model :${attendance.name}');
      // await markAttendance(currentDate);
    } else
    // (!isPresent
    // && alreadyPresent)
    {
      studentAttendance.removeWhere((attendace) =>
          attendace.name == student.name && attendace.batch == student.batch);
      await removeAttendance(DateTime.now().toIso8601String());
    }
    // print(studentAttendance.map((e) => e.name).toList());

    setState(() {});

    // print(attendance.name);

    // // print(attendance.status);
    print(student.name);
  }
}


// Future<void> addAttendenceToHive(AttendanceModel value) async {
//   final attendanceBox = await Hive.openBox<AttendanceModel>('attendece_db');
//   await attendanceBox.add(value);
//   await getTodayAttendees();
// }

