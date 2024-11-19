import 'package:flutter/material.dart';
import 'package:prototype/models/admin_model.dart';
import 'package:prototype/models/attendence_model.dart';

class AttendanceCell extends StatefulWidget {
  final BatchModel student;
  final List<AttendanceModel> studentAttendence;
  final Function(bool) onAddTap;

  const AttendanceCell({
    Key? key,
    required this.student,
    required this.studentAttendence,
    required this.onAddTap,
  }) : super(key: key);

  @override
  _AttendanceCellState createState() => _AttendanceCellState();
}

class _AttendanceCellState extends State<AttendanceCell> {
  List<AttendanceModel> studentAttendence = [];
  // bool? isPresent=false;
  @override
  Widget build(BuildContext context) {
//  isPresent ??= null;
    bool isPresent = widget.studentAttendence.contains(widget.student);

    return InkWell(
      onTap: () {
       widget.onAddTap(isPresent);
      },
      child: Container(
        height: 30,
        decoration: BoxDecoration(
          color: isPresent
              ? Colors.black
              : (isPresent ? Colors.red : Colors.green),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            isPresent ? 'ADD' : (isPresent ? 'REMOVE' : 'ADDED'),
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
