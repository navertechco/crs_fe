import 'package:flutter/material.dart';
import 'package:counter/counter.dart';

import '../../index.dart';

class RoundedFormCounterField extends StatelessWidget {
  final bool disabled;
  final double left;
  final double top;
  final double width;
  final double height;
  final double fontSize;
  final String hintText;

  final void Function(num?)? onValueChanged;
  final int initial;
  final int min;
  final int max;
  final int bound;
  final int step;
  final bool original;

  RoundedFormCounterField(
      {Key? key,
      required this.hintText,
      this.left = 45,
      this.top = 10,
      this.width = 0.2,
      this.height = 0.06,
      this.fontSize = 0.1,
      this.onValueChanged,
      this.initial = 0,
      this.min = 0,
      this.max = 10,
      this.bound = 0,
      this.step = 1,
      this.disabled = false,
      this.original = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var counter = Counter(
      initial: initial < min ? min : initial,
      min: initial > min ? min : initial,
      max: initial <= max ? max : initial,
      bound: bound < initial ? initial : bound,
      step: step,
      onValueChanged: onValueChanged ?? (value) {},
    );

    if (original) {
      counter = Counter(
        initial: initial,
        min: min,
        max: max,
        bound: bound,
        step: step,
        onValueChanged: onValueChanged ?? (value) {},
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width * isMobile * width,
      height: MediaQuery.of(context).size.height * isMobile * height,
      padding: EdgeInsets.only(left: isMobile * left, top: isMobile * top),
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(50)),
      foregroundDecoration: BoxDecoration(
          color: Color.fromARGB(0, 0, 0, 0),
          borderRadius: BorderRadius.circular(50)),
      child: counter,
    );
  }
}
