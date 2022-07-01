import 'package:flutter/material.dart';
import '../index.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';

class CustomFormMultiDropDownFieldWidget extends StatelessWidget {
  const CustomFormMultiDropDownFieldWidget({
    Key? key,
    this.label = '',
    this.hintText = '',
    this.fontSize = 10,
    this.height = 1,
    required this.data,
    required this.value,
    required this.onSaved,
    required this.onChanged,
    this.validator,
    this.enabled,
  }) : super(key: key);
  final height;
  final String? Function(dynamic)? validator;
  final List<String> value;
  final onSaved;
  final onChanged;
  final String label;
  final String? hintText;
  final List<Map<String, dynamic>> data;
  final enabled;
  final fontSize;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          CustomFormLabelWidget(
              fontSize: fontSize, label: label, fontWeight: FontWeight.normal),
          // SizedBox(width: MediaQuery.of(context).size.width * 0.003),
          RoundedFormMultiDropdown(
              height: height * 1.0,
              fontSize: fontSize * 1.0,
              validator: validator,
              value: value,
              data: data,
              hintText: hintText,
              label: label,
              onSaved: onSaved,
              onChanged: onChanged,
              enabled: enabled)
        ],
      ),
    );
  }
}
