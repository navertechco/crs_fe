import 'package:flutter/material.dart';

import '../index.dart';

class CustomFormTextFieldWidget extends StatelessWidget {
    CustomFormTextFieldWidget(
      {Key? key,
      this.label = "",
      this.hintText = "",
      this.keyboardType = TextInputType.text,
      this.validator,
      this.width = 0.2,
      this.height = 0.05})
      : super(key: key);

  final String label;
  final String hintText;
  final double width;
  final double height;
  final TextInputType? keyboardType;
   String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CustomFormLabelWidget(label: label, fontWeight: FontWeight.normal),
          RoundedFormField(
              onSaved: (value) {},
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
