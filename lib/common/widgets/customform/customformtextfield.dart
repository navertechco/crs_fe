import 'package:flutter/material.dart';

import '../index.dart';

// ignore: must_be_immutable
class CustomFormTextFieldWidget extends StatelessWidget {
  CustomFormTextFieldWidget(
      {Key? key,
      this.label = "",
      this.hintText = "",
      this.keyboardType = TextInputType.text,
      this.validator,
      this.width = 0.2,
      this.height = 0.05,
      this.disabled = false,
      this.value,
      required this.onSaved,
      this.onChanged})
      : super(key: key);

  final String label;
  final String hintText;
  final double width;
  final double height;
  final TextInputType? keyboardType;
  String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  final bool disabled;
  final value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CustomFormLabelWidget(label: label, fontWeight: FontWeight.normal),
          RoundedFormField(
              initialValue: value.toString(),
              disabled: disabled,
              onSaved: onSaved,
              onChanged: onChanged,
              hintText: hintText,
              keyboardType: keyboardType,
              validator: validator,
              width: width,
              height: height),
        ],
      ),
    );
  }
}
