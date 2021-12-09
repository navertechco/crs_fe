import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/index.dart';

class CustomExperienceForm extends StatelessWidget {
  const CustomExperienceForm({
    Key? key,
    required this.destination,
  }) : super(key: key);
  final String destination;
  @override
  Widget build(BuildContext context) {
    var destinations = getContext('destinations');
    return Obx(() {
      if (globalctx.destinationlist.contains(destination)) {
        return SizedBox(
          child: Scrollbar(
              child: SingleChildScrollView(
            child: Column(children: [
              CustomTitleWidget(
                width: 0.2,
                fontWeight: FontWeight.bold,
                label: "${destinations[destination][1]}",
              ),
              const CustomFormMultiDropDownFieldWidget(
                // label: "Exploration Days",
                hintText: "             Activities",
                data: [
                  {"code": "1", "description": "act 1"},
                  {"code": "2", "description": "act 2"},
                  {"code": "3", "description": "act 3"},
                  // {"code": "2", "description": "hola 2"},
                ],
              ),
              const CustomFormDropDownFieldWidget(
                // label: "Exploration Days",
                hintText: "Travel Rithm",
                data: [
                  {"code": "1", "description": "Soft"},
                  {"code": "2", "description": "Medium"},
                  {"code": "3", "description": "Hard"},
                  // {"code": "2", "description": "hola 2"},
                ],
              ),
            ]),
          )),
        );
      } else {
        return const Text("");
      }
    });
  }
}
