import 'package:checkbox_formfield/checkbox_formfield.dart';
import 'package:flutter/material.dart';

import '../../../index.dart';

class CheckboxField extends StatelessWidget {
  CheckboxField({
    Key? key,
    this.fontWeight = FontWeight.normal,
    required this.label,
    this.color = Colors.black,
    this.trueIconColor = Colors.grey,
    this.initialValue,
    this.enabled = false,
    this.iconSize = 32,
    required this.onSaved,
    required this.onChanged,
  }) : super(key: key);
  FontWeight fontWeight;
  final String label;
  final Color color;
  final MaterialColor trueIconColor;
  final initialValue;
  final bool enabled;
  final double iconSize;
  final onSaved;
  final onChanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomTitleWidget(
            fontWeight: fontWeight,
            label: label,
            color: color),
        CheckboxIconFormField(
          context: context,
          trueIconColor: trueIconColor,
          initialValue:
              initialValue,
          enabled: enabled,
          iconSize: iconSize,
          onSaved: onSaved,
          onChanged: onChanged,
        ),
      ],
    );
  }
}