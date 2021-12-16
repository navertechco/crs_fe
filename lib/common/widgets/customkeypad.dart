import 'package:flutter/material.dart';

import 'customformlabel.dart';

class CustomKeypadWidget extends StatelessWidget {
  const CustomKeypadWidget({
    Key? key,
    required this.width,
    this.onNext,
    this.onPrevious,
  }) : super(key: key);
  final double width;
  final onNext;
  final onPrevious;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onPrevious,
          child: const CustomFormLabelWidget(
              label: "        Previous", fontWeight: FontWeight.normal),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * width),
        GestureDetector(
          onTap: onNext,
          child: const CustomFormLabelWidget(
              label: "Next", fontWeight: FontWeight.normal),
        ),
      ],
    );
  }
}
