import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import '../../../../index.dart';

class CustomExperienceForm extends StatelessWidget {
  const CustomExperienceForm({
    Key? key,
    required this.experience,
  }) : super(key: key);
  final String experience;
  @override
  Widget build(BuildContext context) {
    var experiences = getContext('experiences');
    RxMap<dynamic, dynamic> localexperience =
        getValue(experiences, experience);

    Rx<String> explorationDay =
        Rx(getValue(localexperience, "exploration_day", "9999"));
    Rx<String> explorationMode =
        Rx(getValue(localexperience, "exploration_mode", "9999"));
    Rx<String> experienceOption =
        Rx(getValue(localexperience, "experience_option", "9999"));
    Rx<String> travelRithm =
        Rx(getValue(localexperience, "travel_rithm", "9999"));

    Rx<List<Map<String, dynamic>>> keyActivities = Rx(
        getValue(localexperience, "key_Activities", <Map<String, dynamic>>[]));

    // ignore: prefer_function_declarations_over_variables
    Function setData = (data, key, value) {
      data[key] = value;
    };

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.05,
              top: MediaQuery.of(context).size.height * 0.1),
          child: SizedBox(
            child: Column(children: [
              CustomTitleWidget(
                width: 0.2,
                fontWeight: FontWeight.bold,
                label: experiences[experience][1],
              ),
              Obx(() {
                return CustomFormDropDownFieldWidget(
                  value: explorationDay.value,
                  onSaved: (value) {
                    setData(localexperience, "exploration_day", value);
                  },
                  onChanged: (value) {
                    setData(localexperience, "exploration_day", value);
                  },
                  label: "Exploration Days     ",
                  data: const [
                    {"code": "1", "description": "1"},
                    {"code": "2", "description": "2"},
                    {"code": "3", "description": "3"},
                    {"code": "4", "description": "4"},
                    {"code": "5", "description": "5"},
                  ],
                );
              }),
              SizedBox(
                child: (() {
                  if (experience == "galapagos") {
                    return Obx(() {
                      return CustomFormDropDownFieldWidget(
                        value: explorationMode.value,
                        onSaved: (value) {
                          setData(localexperience, "exploration_mode", value);
                        },
                        onChanged: (value) {
                          setData(localexperience, "exploration_mode", value);
                        },
                        label: "Exploration Mode   ",
                        data: const [
                          {"code": "1", "description": "Cruiser"},
                          {"code": "2", "description": "Hop Island"},
                          {"code": "3", "description": "Mixed"},
                        ],
                      );
                    });
                  }
                })(),
              ),
              Obx(() {
                return CustomFormDropDownFieldWidget(
                  value: experienceOption.value,
                  onSaved: (value) {
                    setData(localexperience, "experience_option", value);
                  },
                  onChanged: (value) {
                    setData(localexperience, "experience_option", value);
                  },
                  label: "experience Option",
                  data: const [
                    {"code": "1", "description": "All included"},
                    {"code": "2", "description": "Leisure Time"},
                    {"code": "3", "description": "Foods Included"},
                    {"code": "4", "description": "Open Credit"},
                  ],
                );
              }),
              Obx(() {
                return CustomFormDropDownFieldWidget(
                  value: travelRithm.value,
                  onSaved: (value) {
                    setData(localexperience, "travel_rithm", value);
                  },
                  onChanged: (value) {
                    setData(localexperience, "travel_rithm", value);
                  },
                  label: "Travel Rithm             ",
                  data: const [
                    {"code": "1", "description": "Soft"},
                    {"code": "2", "description": "Medium"},
                    {"code": "3", "description": "Hard"},
                    // {"code": "2", "description": "hola 2"},
                  ],
                );
              }),
              Obx(() {
                return CustomFormMultiDropDownFieldWidget(
                  value: keyActivities.value,
                  onSaved: (value) {
                    setData(localexperience, "key_activities", value);
                  },
                  onChanged: (value) {
                    // setData(localexperience,"key_activities", value);
                  },
                  hintText: " ",
                  label: "Key Activities            ",
                  data: const [
                    {"code": "1", "description": "Adventure"},
                    {"code": "2", "description": "Culture"},
                    {"code": "3", "description": "History"},
                    {"code": "4", "description": "Education"},
                    {"code": "5", "description": "Culinary"},
                    {"code": "6", "description": "Nature"},
                    {"code": "7", "description": "Wellness"},
                    {"code": "8", "description": "Surprise"},
                    {"code": "9", "description": "Romance"},
                    // {"code": "2", "description": "hola 2"},
                  ],
                );
              }),
              const Divider(color: Color.fromARGB(255, 0, 0, 0)),
            ]),
          ),
        ),
      ],
    );
  }
}
