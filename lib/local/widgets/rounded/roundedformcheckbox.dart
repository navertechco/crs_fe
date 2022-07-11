// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/index.dart';

class RoundedFormCheckbox extends StatelessWidget {
  final double left;
  final double top;
  final double width;
  final double height;
  final fontSize;
  final String? hintText;
  final String? label;
  final int? value;
  final groupValue;
  List<Map<String, dynamic>> data;
  final onChanged;

  RoundedFormCheckbox(
      {Key? key,
      required this.data,
      this.hintText,
      this.label,
      this.left = 15,
      this.top = 0.1,
      this.width = 0.2,
      this.height = 0.01,
      this.fontSize = 10,
      this.password = false,
      this.value = 0,
      required this.groupValue,
      required this.onChanged})
      : super(key: key);

  bool password;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * isMobile * width,
        height: MediaQuery.of(context).size.height * isMobile * height,
        padding: EdgeInsets.only(
          left: isMobile * left,
          top: isMobile * top,
        ),
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(50)),
        child: Row(
          children: [
            Obx(() {
              return Radio(
                  value: value,
                  groupValue: groupValue.value,
                  onChanged: onChanged);
            }),
            CustomFormLabelWidget(
                fontSize: fontSize,
                label: hintText!,
                fontWeight: value == groupValue.value
                    ? FontWeight.bold
                    : FontWeight.normal),
          ],
        ));
  }
}
