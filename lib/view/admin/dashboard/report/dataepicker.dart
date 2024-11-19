import 'package:flutter/material.dart';

import 'package:prototype/components/app_bar.dart';
import 'package:prototype/models/admin_model.dart';
import 'package:prototype/models/attendence_model.dart';
import 'package:prototype/view/admin/dashboard/report/reports.dart';

class DatePicker extends StatefulWidget {
  List<AttendanceModel> attandance;
  List<BatchModel> presentStudent;
  DatePicker(
      {super.key, required this.attandance, required this.presentStudent});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime selectedDate = DateTime.now();
  DateTimeRange selectedRange =
      DateTimeRange(start: DateTime(2019), end: DateTime(2050));

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime(2019),
        lastDate: DateTime(2050),
        routeSettings: const RouteSettings());
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
      // print(selectedDate);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (ctx) => Report(
                    attendance: widget.presentStudent,
                    // presentStudents:  attendenceNotifier.value ,
                    presentStudents: widget.attandance,
                    pickedDate: selectedDate,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: MyAppBar(
              automaticallyImplyLeading: true,
              iconThemeData: const IconThemeData(color: Colors.white),
              appbartitle: '')),
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${selectedDate.day} - ${selectedDate.month} - ${selectedDate.year} ',
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              style: const ButtonStyle(
                  elevation: MaterialStatePropertyAll(5),
                  padding: MaterialStatePropertyAll(EdgeInsets.all(20)),
                  iconColor: MaterialStatePropertyAll(Colors.white),
                  backgroundColor: MaterialStatePropertyAll(Colors.black)),
              onPressed: () {
                _selectDate(context);
              },
              label: const Text(
                'Choose Date',
                style: TextStyle(color: Colors.white),
              ),
              icon: const Icon(Icons.calendar_month_outlined),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
                '${selectedRange.start.day} - ${selectedRange.start.month} - ${selectedRange.start.year}  to  ${selectedRange.end.day} - ${selectedRange.end.month} -${selectedRange.end.year}'),
            MaterialButton(
              color: Colors.black,
              textColor: Colors.white,
              onPressed: () async {
                final DateTimeRange? dateTimeRange = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(2019),
                    lastDate: DateTime(2050));
                if (dateTimeRange != null && dateTimeRange != selectedRange) {
                  setState(() {
                    selectedRange = dateTimeRange;
                  });
                }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => Report(
                              attendance: widget.presentStudent,
                              // presentStudents:  attendenceNotifier.value ,
                              presentStudents: widget.attandance,
                              pickedDate: selectedDate,
                            )));
              },
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Text('Get List of Reports'),
              ),
            )
          ],
        ),
      )),
    );
  }
}
