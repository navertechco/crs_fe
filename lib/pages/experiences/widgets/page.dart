// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/index.dart';
import 'package:naver_crs/pages/destination/widgets/index.dart';
import '../index.dart';
import 'index.dart';

/// hello
class ExperiencesWidget extends GetView<ExperiencesController> {
  const ExperiencesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: const [
      CustomLeftOptionsWidget(),
      CustomRightDayWidget(),
    ]);
  }
}

class CustomRightDayWidget extends StatelessWidget {
  const CustomRightDayWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.3,
          left: MediaQuery.of(context).size.width * 0.38),
      child: Column(
        children: [
          Row(
            children: const [
              CustomTitleWidget(
                fontWeight: FontWeight.bold,
                label: "Date: ",
              ),
              CustomTitleWidget(
                fontWeight: FontWeight.bold,
                label: "25TH April 2022",
              ),
            ],
          ),
          Divider(color: Color.fromARGB(255, 0, 0, 0)),
          CustomTitleWidget(
            fontWeight: FontWeight.bold,
            label: "Destination: Cuenca",
          ),
          Divider(color: Color.fromARGB(255, 0, 0, 0)),
          Container(
            height: MediaQuery.of(context).size.height * 0.23,
            child: SingleChildScrollView(
              child: Column(
                children: const [
                  CustomTitleWidget(
                    fontWeight: FontWeight.bold,
                    label:
                        "                                                      Selected Experiences",
                  ),
                  Divider(color: Color.fromARGB(255, 0, 0, 0)),
                  CustomExperiencesListWidget(),
                ],
              ),
            ),
          ),
          Divider(color: Color.fromARGB(255, 0, 0, 0)),
          Container(
            height: MediaQuery.of(context).size.height * 0.23,
            child: SingleChildScrollView(
              child: Column(
                children: const [
                  CustomTitleWidget(
                    fontWeight: FontWeight.bold,
                    label:
                        "                                                      Sugested Experiences",
                  ),
                  Divider(color: Color.fromARGB(255, 0, 0, 0)),
                  CustomExperiencesListWidget(),
                ],
              ),
            ),
          ),
          Divider(color: Color.fromARGB(255, 0, 0, 0)),
          CustomKeypadWidget(
              nextlabel: "Next >",
              prevlabel: "< Previous ",
              onNext: () {
                Get.toNamed("/Resume");
              },
              onPrevious: () {
                Get.back();
              },
              width: 0.4),
        ],
      ),
    );
  }
}

class CustomExperiencesListWidget extends StatelessWidget {
  const CustomExperiencesListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var list = <Widget>[];
    var experiences = getContext("experiences");
    for (var experience in experiences.keys) {
      list.add(
        Row(
          children: [
            ExperienceOptionWidget(experience: experience),
            Image.asset("assets/custom/img/greencheck.png",
                width: MediaQuery.of(context).size.width * 0.02),
          ],
        ),
      );
    }
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.45,
      child: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: list,
          ),
        ),
      ),
    );
  }
}

class CustomLeftOptionsWidget extends StatelessWidget {
  const CustomLeftOptionsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.3,
          left: MediaQuery.of(context).size.width * 0.05),
      child: Column(
        children: [
          CustomTitleWidget(
            fontWeight: FontWeight.bold,
            label: "Day 2: Options",
          ),
          Divider(color: Color.fromARGB(255, 0, 0, 0)),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Scrollbar(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomFormMultiDropDownFieldWidget(
                      // label: "Exploration Days",
                      value: const [],
                      onSaved: (value) {},
                      onChanged: (value) {},
                      hintText: "                  Services",
                      data: const [
                        {"code": "1", "description": "Translator"},
                        {"code": "2", "description": "Transport"},
                        {"code": "3", "description": "Guide"},
                        // {"code": "2", "description": "hola 2"},
                      ],
                    ),
                    CustomFormDropDownFieldWidget(
                      // label: "Exploration Days",
                      onSaved: (value) {},
                      onChanged: (value) {},
                      hintText: "Travel Options",
                      data: const [
                        {"code": "1", "description": "All included"},
                        {"code": "2", "description": "Leisure Time"},
                        {"code": "3", "description": "Foods Included"},
                        {"code": "4", "description": "Open Credit"},
                      ],
                    ),
                    CustomFormDropDownFieldWidget(
                      // label: "Exploration Days",
                      onSaved: (value) {},
                      onChanged: (value) {},
                      hintText: "Galapagos Tour Options",
                      data: const [
                        {"code": "1", "description": "Cruiser"},
                        {"code": "2", "description": "Hotel"},
                        {"code": "3", "description": "Mixed"},
                      ],
                    ),
                    CustomFormDropDownFieldWidget(
                      // label: "Exploration Days",
                      onSaved: (value) {},
                      onChanged: (value) {},
                      hintText: "Galapagos Transport Options",
                      data: const [
                        {"code": "1", "description": "Island Hopping"},
                        {"code": "2", "description": "Cruiser"},
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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
    var experiences = getContext("experiences");
    var list = <Widget>[];

    for (var experience in experiences.keys) {
      list.add(CustomExperienceForm(experience: experience));
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width * 0.5,
      child: Scrollbar(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Expanded(
            child: Row(
              children: list,
            ),
          ),
        ),
      ),
    );
  }
}
