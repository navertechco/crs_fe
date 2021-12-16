// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/index.dart';
import '../index.dart';
import 'index.dart';

/// hello
class ActivitiesWidget extends GetView<ActivitiesController> {
  const ActivitiesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      const CustomParentExperienceOptionsWidget(),
      Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.3,
            left: MediaQuery.of(context).size.width * 0.38),
        child: Column(
          children: [
            CustomTitleWidget(
              fontWeight: FontWeight.bold,
              label: "Day 2",
            ),
            Divider(color: Color.fromARGB(255, 0, 0, 0)),
            CustomTitleWidget(
              fontWeight: FontWeight.bold,
              label:
                  "                                                                     Sugested Experiences",
            ),
            Divider(color: Color.fromARGB(255, 0, 0, 0)),
            CustomParentDaysWidget(),
            Divider(color: Color.fromARGB(255, 0, 0, 0)),
            CustomTitleWidget(
              fontWeight: FontWeight.bold,
              label:
                  "                                                                   Experience Options",
            ),
            Divider(color: Color.fromARGB(255, 0, 0, 0)),
            CustomParentExpererienceWidget(),
            Divider(color: Color.fromARGB(255, 0, 0, 0)),
            CustomKeypadWidget(
                onNext: () {
                  Get.toNamed("/Resume");
                },
                onPrevious: () {
                  Get.back();
                },
                width: 0.4),
          ],
        ),
      ),
    ]);
  }
}

class CustomParentDaysWidget extends StatelessWidget {
  const CustomParentDaysWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              ExpereinceOptionWidget(experience: "coast"),
              ExpereinceOptionWidget(experience: "guayaquil"),
              ExpereinceOptionWidget(experience: "cuenca"),
              ExpereinceOptionWidget(experience: "volcano"),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomParentExperienceOptionsWidget extends StatelessWidget {
  const CustomParentExperienceOptionsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.3,
          left: MediaQuery.of(context).size.width * 0.05),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const CustomTitleWidget(
                  fontWeight: FontWeight.bold,
                  label: "       Options",
                ),
                CustomFormDropDownFieldWidget(
                  // label: "Exploration Days",
                  onSaved: (value) {},
                  hintText: "Arrvial Port",
                  data: const [
                    {"code": "1", "description": "Quito"},
                    {"code": "2", "description": "Guayaquil"},
                  ],
                ),
                CustomFormDropDownFieldWidget(
                  onSaved: (value) {},
                  // label: "Exploration Days",
                  hintText: "Departure Port",
                  data: const [
                    {"code": "1", "description": "Quito"},
                    {"code": "2", "description": "Guayaquil"},
                  ],
                ),
                const CustomFormMultiDropDownFieldWidget(
                  // label: "Exploration Days",

                  hintText: "         Travel options",
                  data: [
                    {"code": "1", "description": "Translator"},
                    {"code": "2", "description": "Transport"},
                    {"code": "3", "description": "Guide"},
                    // {"code": "2", "description": "hola 2"},
                  ],
                ),
                CustomFormDropDownFieldWidget(
                  // label: "Exploration Days",
                  onSaved: (value) {},
                  hintText: "experience Option",
                  data: const [
                    {"code": "1", "description": "All included"},
                    {"code": "2", "description": "Leisure Time"},
                    {"code": "3", "description": "Foods Included"},
                    {"code": "4", "description": "Open Credit"},
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomParentExpererienceWidget extends StatelessWidget {
  const CustomParentExpererienceWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width * 0.5,
      child: Scrollbar(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Expanded(
            child: Row(
              children: const [
                CustomExperienceForm(experience: "coast"),
                CustomExperienceForm(experience: "guayaquil"),
                CustomExperienceForm(experience: "cuenca"),
                CustomExperienceForm(experience: "volcano"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
