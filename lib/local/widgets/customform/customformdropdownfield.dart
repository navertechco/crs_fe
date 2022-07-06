import 'package:flutter/material.dart';
import '../index.dart';
import 'package:naver_crs/index.dart';

// ignore: must_be_immutable
class CustomFormDropDownFieldWidget extends StatelessWidget {
  CustomFormDropDownFieldWidget(
      {Key? key,
      this.disabled = false,
      required this.data,
      this.label = '',
      this.hintText,
      this.width = 0.2,
      this.height = 0.05,
      this.value = "0",
      required this.onSaved,
      required this.onChanged,
      this.validator,
      this.fontSize = 10})
      : super(key: key);
  final fontSize;
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
          CustomFormLabelWidget(
              fontSize: fontSize, label: label, fontWeight: FontWeight.normal),
          if (data.isNotEmpty)
            RoundedFormDropdown(
                fontSize: fontSize * 1.0,
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
