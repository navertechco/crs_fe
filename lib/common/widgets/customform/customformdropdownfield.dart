import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../index.dart';

// ignore: must_be_immutable
class CustomFormDropDownFieldWidget extends StatelessWidget {
  CustomFormDropDownFieldWidget(
      {Key? key,
      this.disabled = false,
      required this.data,
      this.label = "",
      this.hintText,
      this.width = 0.2,
      this.height = 0.05,
      this.value = "9999",
      required this.onSaved,
      required this.onChanged,
      this.validator})
      : super(key: key);

  final String label;
  final String? hintText;
  final double width;
  final double height;
  List<Map<String, dynamic>> data;
  void Function(String?) onSaved;
  void Function(String?) onChanged;
  final String value;
  final bool disabled;
  final String? Function(String?)? validator;

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
              disabled: disabled,
              validator: validator)
        ],
      ),
    );
  }
}
