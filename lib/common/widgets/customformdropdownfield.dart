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
      required this.onSaved})
      : super(key: key);

  final String label;
  final String hintText;
  final double width;
  final double height;
   List<Map<String, dynamic>> data;
  final void Function(String?) onSaved;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CustomFormLabelWidget(label: label, fontWeight: FontWeight.normal),
          RoundedFormDropdown(
            width: width,
            data: data,
            hintText: hintText,
            label: label,
            onSaved: onSaved,
          )
        ],
      ),
    );
  }
}
