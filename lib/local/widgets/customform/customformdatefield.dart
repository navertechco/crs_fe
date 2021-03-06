import 'package:flutter/material.dart';
import '../index.dart';
import 'package:naver_crs/index.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class CustomFormDateFieldWidget extends StatelessWidget {
  CustomFormDateFieldWidget(
      {Key? key,
      this.label = '',
      this.hintText = '',
      this.width = 0.2,
      this.height = 0.05,
      this.onChanged,
      this.onSaved,
      this.validator,
      this.fontSize = 10,
      this.initialValue,
      this.disabled = false})
      : super(key: key);
  final fontSize;
  final String label;
  final String hintText;
  final double width;
  final double height;
  void Function(DateTime?)? onChanged;
  void Function(DateTime?)? onSaved;
  String? Function(DateTime?)? validator;
  final disabled;
  DateTime? initialValue;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CustomFormLabelWidget(
              fontSize: fontSize, label: label, fontWeight: FontWeight.normal),
          RoundedFormDatepicker(
              fontSize: fontSize,
              disabled: disabled,
              validator: validator,
              onChanged: onChanged,
              onSaved: onSaved,
              initialValue: initialValue,
              format: DateFormat.yMEd(),
              hintText: hintText,
              width: width,
              height: height),
        ],
      ),
    );
  }
}
