import 'package:flutter/material.dart';
import '../index.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CustomFormCheckboxWidget extends StatelessWidget {
  CustomFormCheckboxWidget(
      {Key? key,
      this.label = '',
      this.hintText = '',
      this.fontSize=10,
      this.width = 0.2,
      this.height = 0.05,
      required this.value,
      required this.groupValue,
      required final onChanged})
      : super(key: key) {
    _onChanged = onChanged;
  }
  final fontSize;
  final String label;
  final String hintText;
  final double width;
  final double height;
  final groupValue;
  List<Map<String, dynamic>> data = [];
  // ignore: prefer_function_declarations_over_variables
  void Function(Rx<String?>?) _onChanged = (Rx<String?>? value) {};
  final int? value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CustomFormLabelWidget(fontSize:fontSize,label: label, fontWeight: FontWeight.normal),
          RoundedFormCheckbox(
            fontSize:fontSize,
            onChanged: _onChanged,
            width: width,
            height: height,
            data: data,
            hintText: hintText,
            label: label,
            value: value,
            groupValue: groupValue,
          ),
        ],
      ),
    );
  }
}
