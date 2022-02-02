import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../index.dart';

class CustomFooterWidget extends StatelessWidget {
  final ExperiencesController ctrl;
  const CustomFooterWidget({
    Key? key,
    required this.ctrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CustomTitleWidget(
              fontWeight: FontWeight.normal,
              label:
                  "If you want not any these experience please click on \"Expand\" to amplify the options",
            ),
            CustomKeypadWidget(
                nextlabel: "< Expand >",
                prevlabel: "",
                onNext: () {
                  setFormValue(ctrl.state.memory, destination.value,
                      "destination_option", "1");
                },
                onPrevious: () {},
                nextFontWeight: FontWeight.bold,
                width: 0.002),
          ],
        ),
        CustomKeypadWidget(
            nextlabel: "Next >",
            prevlabel: "< Previous ",
            onNext: () {
              var day = {
                "date": "",
                "observation": "",
                "day_description": "",
                "day_name": "",
                "parent": 0,
                "option_id": 1,
                "transport_id": 1,
                "key_activities": [],
                "meals": [],
                "experiences": [],
                "destination": destination.value
              };

              var experience = {
                "destination": "",
                "day": "",
                "title": "",
                "description": "",
                "next": "",
                "previous": "",
                "experience_id": "",
                "photo": ""
              };

              globalctx.memory.value["days"][currentDay.value] ??= {};
              globalctx.memory.value["days"][currentDay.value] = day;
              print(globalctx.memory.value["days"]);
              if (currentDay.value < globalctx.memory["totalDays"] - 1) {
                currentDay.value += 1;
                destination.value = processDays(currentDay)["destination"];
              } else {
                Get.toNamed("/Resume");
              }
            },
            onPrevious: () {
              if (currentDay.value > 0) {
                currentDay.value -= 1;
                destination.value = processDays(currentDay)["destination"];
              } else {
                Get.back();
              }
            },
            width: 0.45),
      ],
    );
  }
}
