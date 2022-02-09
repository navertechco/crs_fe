
import 'package:flutter/material.dart';

import 'custompadingtitle.dart';

class CustomFormHeaderRowWidget extends StatelessWidget {
  const CustomFormHeaderRowWidget({
    Key? key,
    required this.customlabel,
    required this.value,
  }) : super(key: key);
  final String customlabel;
  final String? value;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomPadingTitleWidget(
            width: 0.02,
            customlabel: customlabel,
            fontWeight: FontWeight.normal),
        Text(value!),
      ],
    );
  }
}
