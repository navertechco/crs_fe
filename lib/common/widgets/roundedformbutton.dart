import 'package:flutter/material.dart';

class RoundedFormButton extends StatelessWidget {
  const RoundedFormButton({
    Key? key,
    required this.label,
    required this.onTap,
    this.horizontal = 30,
    this.vertical = 30,
    this.fontSize,
    this.width = 0.2,
    this.height = 0.11,
  }) : super(key: key);

  final double horizontal;
  final double vertical;
  final double width;
  final double height;
  final double? fontSize;
  final String label;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * width,
        height: MediaQuery.of(context).size.height * height,
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(36)),
        child: Text(
          label,
          style: TextStyle(
              color: Colors.white,
              fontSize: fontSize ?? MediaQuery.of(context).size.height * 0.025,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
