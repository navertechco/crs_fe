// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

import '../../../../../index.dart';

class LeftHeader extends HookWidget {
  const LeftHeader({
    Key? key,
    required this.ctrl,
    required this.counter,
  }) : super(key: key);
  final ValueNotifier<int> counter;
  final ExperiencesController ctrl;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // var destination = processDays()["destination"];
      var add = 1;
      var day = currentDay.value + add;
      if (destination.value == "departure") {
        add = 0;
      }
      if (currentDay.value == 1) {
        add = 0;
      }
      if (day > 1) {
        day -= 1;
      }

      return Column(
        children: [
          CustomTitleWidget(
            fontWeight: FontWeight.bold,
            label: "Day $day :  ${destination.toString().capitalize}",
          ),
          CustomTitleWidget(
            fontWeight: FontWeight.bold,
            label: "______________________",
          ),
        ],
      );
    });
  }
}
