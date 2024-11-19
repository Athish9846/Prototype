import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:prototype/components/app_bar.dart';
import 'package:prototype/controller/hive_attendence.dart';
import 'package:prototype/models/admin_model.dart';
import 'package:prototype/models/attendence_model.dart';

ValueNotifier<AttendanceModel?> presentAttendance = ValueNotifier(null);

class Report extends StatefulWidget {
  final List<AttendanceModel>? presentStudents;
  AttendanceModel? studentAttendance;
  final List<BatchModel>? attendance;
  DateTime? pickedDate;

  Report(
      {Key? key,
      this.attendance,
      this.presentStudents,
      this.pickedDate,
      this.studentAttendance})
      : super(key: key);

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  List<AttendanceModel> sortedList = [];
  List<AttendanceModel> tempList = [];
  int? presentStudentCount;

  @override
  void initState() {
    super.initState();
    getTodayAttendees();
    sortedList.clear();
    // print(attendeanceNotifier.value.first.date);
    dateSort();
    caluculatePresentStudentCount();
  }

  // void dateSort() {
  //   tempList = attendeanceNotifier.value;
  //   for (var model in attendeanceNotifier.value) {
  //     if (widget.pickedDate!.toString().substring(0, 10) ==
  //         model.date!.substring(0, 10)) {
  //       tempList.add(model);
  //     }
  //     setState(() {
  //       sortedList = tempList;
  //     });
  //   }
  // }

  void dateSort() {
    print(attendeanceNotifier.value.length);
    print(widget.pickedDate.toString().substring(0, 10));
    tempList = attendeanceNotifier.value;
    for (var model in tempList) {
      if (widget.pickedDate.toString().substring(0, 10) ==
          model.date!.substring(0, 10)) {
        sortedList.add(model);

      }
    }
  }

  // void dateSort() {
  //   tempList = attendeanceNotifier.value
  //       .where((model) => model.date == widget.pickedDate)
  //       .toList();
  //   setState(() {
  //     sortedList = tempList;
  //   });
  // }

  void caluculatePresentStudentCount() {
    presentStudentCount = widget.presentStudents!
        .where((student) =>
            sortedList.any((attendance) => attendance.name == student.name))
        .length;
    setState(() {
      presentStudentCount;
    });
  }

  Future<Uint8List> generateDocument(
    PdfPageFormat format,
  ) async {
    // List<AttendanceModel> attendence ..in near to ,format

    final doc = pw.Document(pageMode: PdfPageMode.outlines);

    final font1 = await PdfGoogleFonts.openSansRegular();
    final font2 = await PdfGoogleFonts.openSansBold();

    doc.addPage(
      pw.Page(
        pageTheme: pw.PageTheme(
          pageFormat: format.copyWith(
            marginBottom: 0,
            marginLeft: 0,
            marginRight: 0,
            marginTop: 0,
          ),
          orientation: pw.PageOrientation.portrait,
          theme: pw.ThemeData.withFont(
            base: font1,
            bold: font2,
          ),
        ),
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.SizedBox(height: 20),
              pw.Text(
                'Attendance sheet',
                style: const pw.TextStyle(fontSize: 25),
              ),
              pw.SizedBox(height: 20),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                children: [
                  pw.Row(children: [
                    pw.Text(
                      'Date :',
                      style: const pw.TextStyle(fontSize: 20),
                    ),
                    // ValueListenableBuilder(valueListenable: attendeanceNotifier, builder: (BuildContext, List<AttendanceModel>, Widget?){}),
                    pw.Text(
                      ' ${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}',
                      style: const pw.TextStyle(fontSize: 20),
                    ),
                  ]),
                  pw.Row(
                    children: [
                      pw.Text(
                        'Present : ',
                        style: const pw.TextStyle(fontSize: 25),
                      ),
                      pw.Text(
                        '$presentStudentCount',
                        style: const pw.TextStyle(fontSize: 25),
                      ),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Table(
                defaultColumnWidth: const pw.FixedColumnWidth(120.0),
                border: pw.TableBorder.all(
                  style: pw.BorderStyle.solid,
                  width: 2,
                ),
                children: [
                  pw.TableRow(children: [
                    pw.Text('Index',
                        textAlign: pw.TextAlign.center,
                        style: const pw.TextStyle(fontSize: 20.0)),
                    pw.Text('Batch',
                        textAlign: pw.TextAlign.center,
                        style: const pw.TextStyle(fontSize: 20.0)),
                    pw.Text('Name',
                        textAlign: pw.TextAlign.center,
                        style: const pw.TextStyle(fontSize: 20.0)),
                  ]),
                  for (var index = 0; index < sortedList.length; index++)
                    pw.TableRow(
                      children: [
                        pw.Text(
                            sortedList.length > index
                                ? '${index + 1}'.toString()
                                : '',
                            textAlign: pw.TextAlign.center,
                            style: const pw.TextStyle(fontSize: 20.0)),
                        pw.Text(
                            sortedList.isNotEmpty
                                ? sortedList[index].batch!
                                : '',
                            textAlign: pw.TextAlign.center,
                            style: const pw.TextStyle(fontSize: 20.0)),
                        //  pw.Text(
                        //   widget.attendance != null && widget.attendance!.isNotEmpty
                        //       ? (index < widget.attendance!.length
                        //           ? widget.attendance![index].batch
                        //           : '')
                        //       : '',
                        //   textAlign: pw.TextAlign.center,
                        //   style: const pw.TextStyle(fontSize: 20.0),
                        // ),
                        pw.Text(
                          index < sortedList.length
                              ? sortedList[index].name!
                              : '',
                          textAlign: pw.TextAlign.center,
                          style: const pw.TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          );
        },
      ),
    );

    return doc.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: MyAppBar(
          automaticallyImplyLeading: true,
          iconThemeData: const IconThemeData(color: Colors.white),
          appbartitle: 'REPORTS',
        ),
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: attendeanceNotifier,
          builder: (context, value, child) {
            return PdfPreview(
              canChangeOrientation: false,
              canDebug: false,
              build: (format) {
                dateSort();
                caluculatePresentStudentCount();
                return generateDocument(format);
              },
            );
          },
        ),
      ),
    );
  }
}
