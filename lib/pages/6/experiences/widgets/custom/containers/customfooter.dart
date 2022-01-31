import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../index.dart';

class CustomFooterWidget extends StatelessWidget {
  final ExperiencesController ctrl;
  CustomFooterWidget({
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
                  setFormValue(ctrl.state.memory, destination,
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
              Get.toNamed("/Resume");
            },
            onPrevious: () {
              Get.back();
            },
            width: 0.45),
      ],
    );
  }
}
