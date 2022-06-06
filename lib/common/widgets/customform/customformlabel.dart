import 'package:flutter/material.dart';
import '../index.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';
import 'package:naver_crs/index.dart';
import 'package:naver_crs/index.dart';

class CustomFormLabelWidget extends StatelessWidget {
  const CustomFormLabelWidget(
      {Key? key,
      required this.label,
      this.fontWeight = FontWeight.normal,
      this.color = Colors.black,
      this.fontSize = 10})
      : super(key: key);
  final String label;
  final FontWeight fontWeight;
  final Color color;
  final fontSize;
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: KTextSytle(
              context: context,
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: color)
          .getStyle(),
    );
  }
}
