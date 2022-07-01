import 'package:flutter/material.dart';
import '../index.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class CustomFormCalendarFieldWidget extends StatelessWidget {
  CustomFormCalendarFieldWidget({
    Key? key,
    this.label = '',
    this.hintText = '',
    this.width = 0.2,
    this.height = 0.05,
    this.disabled = false,
    this.onValueChanged,
    this.initial,
    this.min,
    this.max,
    this.bound,
    this.step,
    this.left = 0,
    this.top = 0,
    this.fontSize = 10,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.black,
    this.initialStartDate,
    this.initialEndDate,
    this.minimumDate,
    this.maximumDate,
    this.startEndDateChange,
    required this.onSaved,
  }) : super(key: key);
  final initialStartDate;
  final initialEndDate;
  final minimumDate;
  final maximumDate;
  final startEndDateChange;
  final void Function() onSaved;
  final label;
  final bool disabled;
  final double left;
  final double top;
  final double width;
  final double height;
  final double fontSize;
  final String hintText;
  final FontWeight fontWeight;
  final Color color;
  final void Function(num?)? onValueChanged;
  final initial;
  final min;
  final max;
  final bound;
  final step;
  List<TextInputFormatter>? inputFormatters;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CustomFormLabelWidget(
              label: label, color: color, fontWeight: fontWeight),
          RoundedFormCalendar(
            label:
                "${initialEndDate.difference(initialStartDate).inDays + 1} days",
            initialStartDate: initialStartDate,
            initialEndDate: initialEndDate,
            minimumDate: minimumDate,
            maximumDate: maximumDate,
            startEndDateChange: startEndDateChange,
            onSaved: onSaved,
            fontSize: fontSize,
          ),
        ],
      ),
    );
  }
}
