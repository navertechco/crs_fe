import 'package:flutter/material.dart';

import '../index.dart';

class CustomFormMultiDropDownFieldWidget extends StatelessWidget {
  const CustomFormMultiDropDownFieldWidget({
    Key? key,
    this.label = "",
    this.hintText,
    required this.data,
  }) : super(key: key);

  final String label;
  final String? hintText;
  final List<Map<String, dynamic>> data;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CustomFormLabelWidget(label: label, fontWeight: FontWeight.normal),
          // SizedBox(width: MediaQuery.of(context).size.width * 0.003),
          RoundedFormMultiDropdown(
            data: data,
            hintText: hintText,
            label: label,
            onSaved: (value) {},
          )
        ],
      ),
    );
  }
}
