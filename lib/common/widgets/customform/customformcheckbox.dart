import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../index.dart';

// ignore: must_be_immutable
class CustomFormCheckboxWidget extends StatelessWidget {
  CustomFormCheckboxWidget(
      {Key? key,
      this.label = "",
      this.hintText = "",
      this.width = 0.2,
      this.height = 0.05,
      required this.value,
      required this.groupValue,
      required final onChanged})
      : super(key: key) {
    _onChanged = onChanged;
  }

  final String label;
  final String hintText;
  final double width;
  final double height;
  final groupValue;
  List<Map<String, dynamic>> data = [];
  void Function(Rx<String?>?) _onChanged = (Rx<String?>? value) {};
  final int? value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          RoundedFormCheckbox(
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
