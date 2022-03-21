import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../index.dart';

// ignore: must_be_immutable
class CustomFormCounterFieldWidget extends StatelessWidget {
  CustomFormCounterFieldWidget({
    Key? key,
    this.label = "",
    this.hintText = "",
    this.width = 0.2,
    this.height = 0.05,
    this.disabled = false,
    this.onValueChanged,
    this.initial,
    this.min,
    this.max,
    this.bound,
    this.step,
    this.left = 0,
    this.top = 0,
    this.fontSize = 10,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.black,
  }) : super(key: key);

  final label;
  final bool disabled;
  final double left;
  final double top;
  final double width;
  final double height;
  final double fontSize;
  final String hintText;
  final FontWeight fontWeight;
  final Color color;
  final void Function(num?)? onValueChanged;
  final initial;
  final min;
  final max;
  final bound;
  final step;
  List<TextInputFormatter>? inputFormatters;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CustomFormLabelWidget(
              label: label, color: color, fontWeight: fontWeight),
          RoundedFormCounterField(
              disabled: disabled,
              hintText: hintText,
              width: width,
              height: height,
              initial: initial,
              min: min,
              max: max,
              bound: bound,
              step: step,
              onValueChanged: onValueChanged),
        ],
      ),
    );
  }
}
