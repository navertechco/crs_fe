import 'package:flutter/material.dart';

import '../index.dart';

class CustomFormTextFieldWidget extends StatelessWidget {
  const CustomFormTextFieldWidget(
      {Key? key,
      this.label = "",
      this.hintText = "",
      this.width = 0.2,
      this.height = 0.02})
      : super(key: key);

  final String label;
  final String hintText;
  final double width;
  final double height;
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
              width: width,
              height: height),
        ],
      ),
    );
  }
}
