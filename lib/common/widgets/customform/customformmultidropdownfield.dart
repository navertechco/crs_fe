import 'package:flutter/material.dart';
import 'package:naver_crs/common/constants.dart';

import '../index.dart';

class CustomFormMultiDropDownFieldWidget extends StatelessWidget {
  const CustomFormMultiDropDownFieldWidget({
    Key? key,
    this.label = "",
    this.hintText,
    required this.data,
    required this.value,
    required this.onSaved,
    required this.onChanged,
    this.validator,
  }) : super(key: key);
  final String? Function(List<Map<String, dynamic>>?)? validator;
  final List<String> value;
  final Function(List<Map<String, dynamic>>?) onSaved;
  final Function(List< String >?) onChanged;
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
            validator: validator,
            value: value,
            data: data,
            hintText: hintText,
            label: label,
            onSaved: onSaved,
            onChanged: onChanged,
          )
        ],
      ),
    );
  }
}
