import 'package:flutter/material.dart';
import '../index.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';

import 'customformlabel.dart';

class CustomKeypadWidget extends StatelessWidget {
  const CustomKeypadWidget({
    Key? key,
    required this.width,
    this.fontSize = 10,
    this.onNext,
    this.onPrevious,
    this.prevlabel = "Previous",
    this.nextlabel = "Next",
    this.nextFontWeight = FontWeight.normal,
    this.prevFontWeight = FontWeight.normal,
  }) : super(key: key);
  final fontSize;
  final double width;
  final String nextlabel;
  final String prevlabel;
  final FontWeight nextFontWeight;
  final FontWeight prevFontWeight;
  final onNext;
  final onPrevious;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onPrevious,
          child: CustomFormLabelWidget(
              fontSize: isMobile * fontSize,
              label: prevlabel,
              fontWeight: prevFontWeight),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * isMobile * width),
        GestureDetector(
          onTap: onNext,
          child: CustomFormLabelWidget(
              fontSize: isMobile * fontSize,
              label: nextlabel,
              fontWeight: nextFontWeight),
        ),
      ],
    );
  }
}
