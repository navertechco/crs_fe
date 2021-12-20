import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../index.dart';

class CustomFormDateFieldWidget extends StatelessWidget {
  const CustomFormDateFieldWidget({
    Key? key,
    this.label = "",
    this.hintText = "",
    this.width = 0.2,
    this.height = 0.05,
  }) : super(key: key);
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
          SizedBox(width: MediaQuery.of(context).size.width * 0.01),
          RoundedFormDatepicker(
              format: DateFormat.yMEd(),
              hintText: hintText,
              width: width,
              height: height),
        ],
      ),
    );
  }
}
