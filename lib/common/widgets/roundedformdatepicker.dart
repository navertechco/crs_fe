// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class RoundedFormDatepicker extends StatelessWidget {
  final double left;
  final double top;
  final double width;
  final double height;
  final DateFormat format;

  const RoundedFormDatepicker({
    Key? key,
    required this.format,
    this.left = 65,
    this.top = 10,
    this.width = 0.2,
    this.height = 0.05,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * width,
      height: MediaQuery.of(context).size.height * height,
      padding: EdgeInsets.only(left: left, top: top),
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(50)),
      child: DateTimeField(
        decoration: const InputDecoration.collapsed(hintText: "Choose a Option"),
        format: format,
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: DateTime.now(),
            lastDate: DateTime(2100),
          );
          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );
            return DateTimeField.combine(date, time);
          } else {
            return currentValue;
          }
        },
      ),
    );
  }
}
