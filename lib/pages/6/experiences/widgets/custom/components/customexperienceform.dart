import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../index.dart';

class CustomExperienceForm extends StatelessWidget {
  const CustomExperienceForm({
    Key? key,
    required this.experience,
  }) : super(key: key);
  final String experience;
  @override
  Widget build(BuildContext context) {
    var experiences = {}.obs;

    getExperiences("", experience).then((value) {
      experiences.value = value;
    });

    return Obx(() {
      return SizedBox(
        child: Scrollbar(
            child: SingleChildScrollView(
          child: Column(children: [
            CustomTitleWidget(
              width: 0.2,
              fontWeight: FontWeight.bold,
              label: "${experiences[1]}",
            ),
            CustomFormMultiDropDownFieldWidget(
              value: const [],
              onSaved: (value) {},
              onChanged: (value) {},
              // label: "Exploration Days",
              hintText: "             Experiences",
              data: const [
                {"code": "1", "description": "act 1"},
                {"code": "2", "description": "act 2"},
                {"code": "3", "description": "act 3"},
                // {"code": "2", "description": "hola 2"},
              ],
            ),
            CustomFormDropDownFieldWidget(
              // label: "Exploration Days",
              onSaved: (value) {},
              onChanged: (value) {},
              hintText: "Travel Rhythm",
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
    });
  }
}
