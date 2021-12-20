import 'package:flutter/material.dart';

import '../index.dart';

class CustomFormDropDownFieldWidget extends StatelessWidget {
  CustomFormDropDownFieldWidget(
      {Key? key,
      required this.data,
      this.label = "",
      this.hintText = "",
      this.width = 0.2,
      this.height = 0.05,
      this.value = "9999",
      required this.onSaved,
      required this.onChanged})
      : super(key: key);

  final String label;
  final String hintText;
  final double width;
  final double height;
  List<Map<String, dynamic>> data;
  void Function(String?) onSaved;
  void Function(String?) onChanged;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CustomFormLabelWidget(label: label, fontWeight: FontWeight.normal),
          RoundedFormDropdown(
            onChanged: onChanged,
            width: width,
            height: height,
            data: data,
            hintText: hintText,
            label: label,
            onSaved: onSaved,
            value: value,
          )
        ],
      ),
    );
  }
}
