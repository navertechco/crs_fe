// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

class LeftHeader extends HookWidget {
  LeftHeader({
    Key? key,
    required this.fontSize,
  }) : super(key: key);
  final int fontSize;

  final type = (() {
    if (currentDay.value == 0) {
      return "Arrival";
    }
    if (currentDay.value == totalDays.value - 1) {
      return "Departure";
    }
    return "Tour";
  })();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Align(
        alignment: Alignment.center,
        child: Text(
            "Day  ${currentDay.value + 1}:  ${globalDestinationName.value.toString().capitalize} $type ",
            style: KTextSytle(
                    context: context,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)
                .getStyle(),
            textAlign: TextAlign.center),
      );
    });
  }
}
