import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/functions/functions.dart';
import 'package:sweetalert/sweetalert.dart';

import '../../../../../index.dart';

class CustomFooterWidget extends StatelessWidget {
  final ExperiencesController ctrl;
  final ValueNotifier<int> counter;
  const CustomFooterWidget({
    Key? key,
    required this.ctrl,
    required this.counter,
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
                  formKey.currentState!.reset();
                  counter.value++;
                  filterSuggestedExperiences();
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
                  resetExperiences();
                },
                prevFontWeight: FontWeight.bold,
                width: 0.01),
          ],
        ),
        CustomKeypadWidget(
            nextlabel: "Next >",
            prevlabel: "< Previous ",
            onNext: () {
              paginateDay(context);
              ctrl.refresh();
            },
            onPrevious: () {
              if (currentDay.value > 0) {
                currentDay.value -= 1;
                destination.value = processDays(currentDay)["destination"];
                filterSuggestedExperiences();
              } else {
                Get.back();
              }
            },
            width: 0.45),
      ],
    );
  }
}
