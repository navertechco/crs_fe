// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:naver_crs/index.dart';

class RoundedFormDatepicker extends StatelessWidget {
  final double left;
  final double top;
  final double width;
  final double height;
  final DateFormat format;
  final fontSize;
  final String hintText;
  void Function(DateTime?)? onChanged;
  void Function(DateTime?)? onSaved;
  String? Function(DateTime?)? validator;
  DateTime? initialValue;
  final disabled;
  RoundedFormDatepicker(
      {Key? key,
      required this.format,
      this.hintText = '',
      this.fontSize = 10,
      this.left = 10,
      this.top = 4,
      this.width = 0.2,
      this.height = 0.04,
      this.onChanged,
      this.onSaved,
      this.validator,
      this.initialValue,
      this.disabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * isMobile * width,
      height: MediaQuery.of(context).size.height * isMobile * height,
      padding: EdgeInsets.only(left: isMobile * left, top: isMobile * top),
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(50)),
      child: DateTimeField(
        enabled: !disabled,
        validator: validator,
        cursorColor: Colors.grey,
        cursorWidth: 1,
        resetIcon: Icon(Icons.cancel, size: isMobile * 1),
        decoration: InputDecoration.collapsed(
            hintText: hintText, enabled: !disabled, fillColor: Colors.red),
        style: KTextSytle(
                color: disabled ? Colors.black45 : Colors.black,
                context: context,
                fontSize: isMobile * fontSize,
                fontWeight: FontWeight.bold)
            .getStyle(),
        format: format,
        onChanged: onChanged,
        onSaved: onSaved,
        initialValue: initialValue,
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: initialValue ?? DateTime.now(),
            lastDate: DateTime(2100),
          );
          if (date != null) {
            final time = TimeOfDay(hour: 12, minute: 00);
            return DateTimeField.combine(date, time);
          } else {
            return currentValue;
          }
        },
      ),
    );
  }
}
