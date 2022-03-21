import 'package:flutter/material.dart';
import 'package:flutter_week_view/flutter_week_view.dart';

class CustomDayWidget extends StatelessWidget {
  const CustomDayWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    return DayView(
      initialTime: const HourMinute(hour: 7),
      date: now,
      events: [
        FlutterWeekViewEvent(
          title: 'Leisure Time',
          description: '',
          start: date.add(const Duration(hours: 10)),
          end: date.add(const Duration(hours: 11, minutes: 30)),
        ),
      ],
      style: DayViewStyle.fromDate(
        date: date,
        currentTimeCircleColor: Colors.pink,
      ),
    );
  }
}
