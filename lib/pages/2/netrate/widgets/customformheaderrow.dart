import 'package:flutter/material.dart';
import '../index.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';

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
        SizedBox(width: MediaQuery.of(context).size.width * 0.01),
        Text("$value",
            style: KTextSytle(
                    context: context,
                    fontSize: 12,
                    fontWeight: FontWeight.normal)
                .getStyle()),
        SizedBox(width: MediaQuery.of(context).size.width * 0.03)
      ],
    );
  }
}
