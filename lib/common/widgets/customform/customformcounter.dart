import 'package:flutter/material.dart';
import '../index.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class CustomFormCounterFieldWidget extends StatelessWidget {
  CustomFormCounterFieldWidget({
    Key? key,
    this.label = '',
    this.hintText = '',
    this.width = 0.2,
    this.height = 0.05,
    this.disabled = false,
    this.onValueChanged,
    this.initial = 0,
    this.min = 0,
    this.max = 10,
    this.bound = 0,
    this.step = 1,
    this.left = 0,
    this.top = 0,
    this.fontSize = 10,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.black,
    this.original = false,
  }) : super(key: key);

  final bool original;
  final String label;
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
  final int initial;
  final int min;
  final int max;
  final int bound;
  final int step;
  List<TextInputFormatter>? inputFormatters;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Wrap(
          children: [
            CustomFormLabelWidget(
                label: label, color: color, fontWeight: fontWeight),
            RoundedFormCounterField(
                disabled: disabled,
                hintText: hintText,
                width: width,
                height: height,
                initial: initial,
                original: original,
                min: min,
                max: max,
                bound: bound,
                step: step,
                onValueChanged: onValueChanged),
            SizedBox(height: MediaQuery.of(context).size.height * 0.061),
          ],
        ),
      ),
    );
  }
}
