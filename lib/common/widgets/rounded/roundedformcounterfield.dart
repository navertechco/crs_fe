import 'package:flutter/material.dart';
import 'package:counter/counter.dart';

class RoundedFormCounterField extends StatelessWidget {
  final bool disabled;
  final double left;
  final double top;
  final double width;
  final double height;
  final double fontSize;
  final String hintText;

  final void Function(num?)? onValueChanged;
  final initial;
  final min;
  final max;
  final bound;
  final step;

  const RoundedFormCounterField(
      {Key? key,
      required this.hintText,
      this.left = 45,
      this.top = 10,
      this.width = 0.2,
      this.height = 0.05,
      this.fontSize = 0.1,
      this.onValueChanged,
      this.initial,
      this.min = 0,
      this.max = 10,
      this.bound = 0,
      this.step = 1,
      this.disabled = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * width,
      height: MediaQuery.of(context).size.height * height,
      padding: EdgeInsets.only(left: left, top: top),
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(50)),
      foregroundDecoration: BoxDecoration(
          color: Color.fromARGB(0, 0, 0, 0),
          borderRadius: BorderRadius.circular(50)),
      child: Counter(
        initial: initial < min ? min : initial,
        min: min,
        max: max,
        bound: bound < initial ? initial : bound,
        step: step ?? 1,
        onValueChanged: onValueChanged ?? (value) {},
      ),
    );
  }
}
