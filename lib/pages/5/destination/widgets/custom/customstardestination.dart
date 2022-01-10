import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import '../../../../index.dart';

class CustomStarDestinationForm extends StatelessWidget {
  const CustomStarDestinationForm({
    Key? key,
    required this.destination,
  }) : super(key: key);
  final String destination;
  @override
  Widget build(BuildContext context) {
    var destinations = getContext('destinations');
    RxMap<dynamic, dynamic> localDestination =
        getValue(destinations, destination);

    Rx<String> explorationDay =
        Rx(getValue(localDestination, "exploration_day", "9999"));
    Rx<String> explorationMode =
        Rx(getValue(localDestination, "exploration_mode", "9999"));
    Rx<String> destinationOption =
        Rx(getValue(localDestination, "destination_option", "9999"));
    Rx<String> travelRithm =
        Rx(getValue(localDestination, "travel_rithm", "9999"));

    Rx<List<Map<String, dynamic>>> keyActivities = Rx(
        getValue(localDestination, "key_Activities", <Map<String, dynamic>>[]));

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
                label: destinations[destination][1],
              ),
              Obx(() {
                return CustomFormDropDownFieldWidget(
                  value: explorationDay.value,
                  onSaved: (value) {
                    setData(localDestination, "exploration_day", value);
                  },
                  onChanged: (value) {
                    setData(localDestination, "exploration_day", value);
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
                  if (destination == "galapagos") {
                    return Obx(() {
                      return CustomFormDropDownFieldWidget(
                        value: explorationMode.value,
                        onSaved: (value) {
                          setData(localDestination, "exploration_mode", value);
                        },
                        onChanged: (value) {
                          setData(localDestination, "exploration_mode", value);
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
                  value: destinationOption.value,
                  onSaved: (value) {
                    setData(localDestination, "destination_option", value);
                  },
                  onChanged: (value) {
                    setData(localDestination, "destination_option", value);
                  },
                  label: "Destination Option",
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
                    setData(localDestination, "travel_rithm", value);
                  },
                  onChanged: (value) {
                    setData(localDestination, "travel_rithm", value);
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
                    setData(localDestination, "key_activities", value);
                  },
                  onChanged: (value) {
                    // setData(localDestination,"key_activities", value);
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
