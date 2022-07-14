import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';

class RoundedFormCalendar extends StatelessWidget {
  final double left;
  final double top;
  final double width;
  final double height;
  final Color color;
  final fontSize;
  final initialStartDate;
  final initialEndDate;
  final minimumDate;
  final maximumDate;
  final startEndDateChange;
  final onSaved;
  final label;

  const RoundedFormCalendar(
      {Key? key,
      this.label,
      this.left = 0,
      this.top = 0,
      this.width = 0.1,
      this.height = 0.05,
      this.color = Colors.grey,
      this.initialStartDate,
      this.initialEndDate,
      this.fontSize = 10,
      this.minimumDate,
      this.maximumDate,
      this.startEndDateChange,
      required this.onSaved})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * width,
        height: MediaQuery.of(context).size.height * height,
        padding: EdgeInsets.only(
          left: left,
          top: top,
        ),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(50)),
        child: Align(
          alignment: Alignment.center,
          child: TextButton(
            child: Text(
              label,
              style: KTextSytle(
                      context: context,
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54)
                  .getStyle(),
            ),
            onPressed: () {
              showCustomDialog(
                context,
                CustomCalendarView(
                  initialStartDate: initialStartDate,
                  initialEndDate: initialEndDate,
                  minimumDate: minimumDate,
                  maximumDate: maximumDate,
                  startEndDateChange: startEndDateChange,
                ),
                "Save",
                backgroundColor: Colors.white,
                onSaved: onSaved,
              );
            },
          ),
        ));
  }
}
