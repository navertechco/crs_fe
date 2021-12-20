import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../index.dart';

class CustomFormLabelWidget extends StatelessWidget {
  const CustomFormLabelWidget({
    Key? key,
    required this.label,
    required this.fontWeight,
  }) : super(key: key);
  final String label;
  final FontWeight fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: KTextSytle(context, 10),
    );
  }
}
