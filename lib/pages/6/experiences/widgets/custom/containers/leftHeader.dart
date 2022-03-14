// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

import '../../../../../index.dart';

class LeftHeader extends HookWidget {
  LeftHeader({
    Key? key,
    required this.ctrl,
    required this.counter,
  }) : super(key: key);
  final ValueNotifier<int> counter;
  final ExperiencesController ctrl;
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
      return Text(
          "Day  ${currentDay.value + 1}:  ${globalDestinationName.value.toString().capitalize} $type ",
          style: KTextSytle(
                  context: context,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)
              .getStyle());
    });
  }
}
