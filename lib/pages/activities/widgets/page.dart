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
      Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.3,
            left: MediaQuery.of(context).size.width * 0.05),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                children: const [
                  CustomTitleWidget(
                    fontWeight: FontWeight.bold,
                    label: "       Options",
                  ),
                  CustomFormDropDownFieldWidget(
                    // label: "Exploration Days",
                    hintText: "Arrvial Port",
                    data: [
                      {"code": "1", "description": "Quito"},
                      {"code": "2", "description": "Guayaquil"},
                    ],
                  ),
                  CustomFormDropDownFieldWidget(
                    // label: "Exploration Days",
                    hintText: "Departure Port",
                    data: [
                      {"code": "1", "description": "Quito"},
                      {"code": "2", "description": "Guayaquil"},
                    ],
                  ),
                  CustomFormMultiDropDownFieldWidget(
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
                    hintText: "Destination Option",
                    data: [
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
      ),
      Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.3,
            left: MediaQuery.of(context).size.width * 0.38),
        child: Column(
          children: [
            const CustomTitleWidget(
              fontWeight: FontWeight.bold,
              label: "Day 2",
            ),
            const Divider(color: Color.fromARGB(255, 0, 0, 0)),
            const CustomTitleWidget(
              fontWeight: FontWeight.bold,
              label:
                  "                                                                     Sugested Experiences",
            ),
            const Divider(color: Color.fromARGB(255, 0, 0, 0)),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: Column(
                    children: const [
                      ExpereinceOptionWidget(destination: "coast"),
                      ExpereinceOptionWidget(destination: "guayaquil"),
                      ExpereinceOptionWidget(destination: "cuenca"),
                      ExpereinceOptionWidget(destination: "volcano"),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(color: Color.fromARGB(255, 0, 0, 0)),
            const CustomTitleWidget(
              fontWeight: FontWeight.bold,
              label:
                  "                                                                   Experience Options",
            ),
            const Divider(color: Color.fromARGB(255, 0, 0, 0)),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.5,
              child: Scrollbar(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Expanded(
                    child: Row(
                      children: const [
                        CustomExperienceForm(destination: "coast"),
                        CustomExperienceForm(destination: "guayaquil"),
                        CustomExperienceForm(destination: "cuenca"),
                        CustomExperienceForm(destination: "volcano"),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Divider(color: Color.fromARGB(255, 0, 0, 0)),
            const CustomKeypadWidget(),
          ],
        ),
      ),
    ]);
  }
}
