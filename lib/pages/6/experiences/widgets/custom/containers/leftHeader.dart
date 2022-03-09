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
      return Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
          child: Column(
            children: [
              CustomTitleWidget(
                fontWeight: FontWeight.bold,
                label:
                    "Day  ${currentDay.value + 1}:  ${globalDestinationName.value.toString().capitalize}",
              ),
              const Divider(
                color: Colors.black,
                height: 25,
                thickness: 2,
                indent: 5,
                endIndent: 5,
              ),
            ],
          ),
        ),
      );
    });
  }
}
