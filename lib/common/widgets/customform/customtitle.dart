import 'package:flutter/material.dart';

import '../index.dart';

class CustomTitleWidget extends StatelessWidget {
  const CustomTitleWidget({
    Key? key,
    required this.label,
    this.fontWeight = FontWeight.normal,
    this.width = 0.15, this.color=Colors.black,
  }) : super(key: key);
  final String label;
  final FontWeight fontWeight;
  final double width;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomFormLabelWidget(label: label, fontWeight: fontWeight, color:color),
        // SizedBox(width: MediaQuery.of(context).size.width * width)
      ],
    );
  }
}
