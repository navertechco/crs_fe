import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sweetalert/sweetalert.dart';

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
        Row(
          children: [
            CustomTitleWidget(
              fontWeight: FontWeight.normal,
              label: "If you want to Reset options click to ->    ",
            ),
            CustomKeypadWidget(
                prevlabel: "< Reset >",
                nextlabel: "",
                onPrevious: () {
                  globalctx.promotedExperiences.value = {};
                  globalctx.experienceDragData.value = {};
                },
                prevFontWeight: FontWeight.bold,
                width: 0.01),
          ],
        ),
        CustomKeypadWidget(
            nextlabel: "Next >",
            prevlabel: "< Previous ",
            onNext: () {
              if (globalctx
                      .promotedExperiences.value[currentDay.value]!.length >
                  0) {
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
                destination.value = processDays(currentDay)["destination"];
                globalctx.memory.value["days"][currentDay.value] ??= {};
                globalctx.memory.value["days"][currentDay.value] = day;
                print(globalctx.memory.value["days"]);
                if (currentDay.value <
                    globalctx.memory["totalDays"].value - 1) {
                  currentDay.value += 1;
                  destination.value = processDays(currentDay)["destination"];
                } else {
                  Get.toNamed("/Resume");
                }
              } else {
                SweetAlert.show(context,
                    title: "Promote any experiences is required",
                    subtitle: 'error',
                    style: SweetAlertStyle.error, onPress: (bool isConfirm) {
                  Get.close(1);
                  return false;
                });
              }
            },
            onPrevious: () {
              // if (currentDay.value > 0) {
              //   currentDay.value -= 1;
              //   destination.value = processDays(currentDay)["destination"];
              // } else {
              //   Get.back();
              // }
            },
            width: 0.45),
      ],
    );
  }
}
