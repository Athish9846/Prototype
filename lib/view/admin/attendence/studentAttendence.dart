import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

class StudentAttendence extends StatefulWidget{
  const StudentAttendence({super.key});

  @override
  State<StudentAttendence> createState() => _StudentAttendenceState();
}

class _StudentAttendenceState extends State<StudentAttendence> {
  final DateTime _currentDate = DateTime.now();
  final Map<DateTime, bool> _attendenceRecords = {};
  @override
  Widget build(BuildContext) {
    return
        //  Scaffold(
        //   appBar: AppBar(backgroundColor: Colors.black,),
        //   body:
        CalendarCarousel(
      onDayPressed: (date, events) {
        (date, events) {
          setState(() {
            _attendenceRecords[date] = !_attendenceRecords.containsKey(date)
                ? true
                : !_attendenceRecords[date]!;
          });
          
        };
      },
      weekdayTextStyle: TextStyle(color: Colors.red),
      todayButtonColor: Colors.grey,
      thisMonthDayBorderColor: Colors.grey,
      showOnlyCurrentMonthDate: true,
      daysHaveCircularBorder: true,
      // headerMargin: EdgeInsets.all(30)
      headerTitleTouchable: true,
      headerTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
      // onHeaderTitlePressed: ,
      // showIconBehindDayText: false,
      // iconColor: Colors.blue,
      // selectedDayTextStyle: TextStyle(backgroundColor: Colors.red),
      customDayBuilder: (isSelectable, index, isSelectedDay, isToday,
          isPrevMonthDay, textStyle, isNextMonthDay, isThisMonthDay, day) {},
      todayTextStyle: TextStyle(color: Colors.amber),
    );
    // );
  }
}

