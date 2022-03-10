import 'package:flutter/material.dart';

import '../../../index.dart';
import 'custompadingtitle.dart';

class CustomFormHeaderRowWidget extends StatelessWidget {
  const CustomFormHeaderRowWidget({
    Key? key,
    required this.customlabel,
    required this.value,
  }) : super(key: key);
  final String customlabel;
  final String? value;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(customlabel,
            style: KTextSytle(
                    context: context, fontSize: 12, fontWeight: FontWeight.bold)
                .getStyle()),
        Text(" $value  ",
            style: KTextSytle(
                    context: context,
                    fontSize: 12,
                    fontWeight: FontWeight.normal)
                .getStyle()),
      ],
    );
  }
}
