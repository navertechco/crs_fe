import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';
import 'package:flutter_week_view/flutter_week_view.dart';
import 'package:get/get.dart';

class CustomDestinationWidget extends StatelessWidget {
  const CustomDestinationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);

    return Obx(() {
      Rx<TimeOfDay?> leisureTimeStart = Rx(getFormValue(
              globalctx.memory["days"],
              currentDay.value,
              "leisureTimeStart",
              time) ??
          time);
      Rx<TimeOfDay?> leisureTimeEnd = Rx(getFormValue(globalctx.memory["days"],
              currentDay.value, "leisureTimeEnd", time) ??
          time);
      var eventList = <FlutterWeekViewEvent>[];

      if (globalctx.memory["days"][currentDay.value.toString()] != null) {
        if (globalctx.memory["days"][currentDay.value.toString()]
                ["leisureTimeEnd"] !=
            null) {
          eventList.add(FlutterWeekViewEvent(
            title: 'Leisure Time',
            description: '',
            start: date.add(Duration(
                hours: leisureTimeStart.value!.hour,
                minutes: leisureTimeStart.value!.minute)),
            end: date.add(Duration(
                hours: leisureTimeEnd.value!.hour,
                minutes: leisureTimeEnd.value!.minute)),
          ));
        }
      }

      return DayView(
        initialTime: const HourMinute(hour: 7),
        date: now,
        events: eventList,
        style: DayViewStyle.fromDate(
          date: date,
          currentTimeCircleColor: Colors.pink,
        ),
      );
    });
  }
}
