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
    var tour = getContext("tour");
    var ctx = globalctx.context.value;
    var destinationData = getParam("DESTINATION_DATA");
    Map<dynamic, dynamic> destinations = getValue(destinationData, "value");
    Rx<Map<dynamic, dynamic>> localDestination =
        Rx(getContext('destinationdata'));

    Rx<dynamic> explorationDay =
        Rx(getValue(localDestination.value, "exploration_days", def: "9999"));
    Rx<dynamic> explorationMode =
        Rx(getValue(localDestination.value, "exploration_mode", def: "9999"));
    Rx<String> destinationOption =
        Rx(getValue(localDestination.value, "destination_option", def: "9999"));
    Rx<String> travelRhythm =
        Rx(getValue(localDestination.value, "travel_rhythm", def: "9999"));

    Rx<List<Map<String, dynamic>>> keyActivities = Rx(getValue(
        localDestination.value, "key_Activities",
        def: <Map<String, dynamic>>[]));

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
                    explorationDay.value = value;
                  },
                  onChanged: (value) {
                    explorationDay.value = value;
                  },
                  label: "Exploration Days     ",
                  data: processCatalog("exploration_days"),
                );
              }),
              SizedBox(
                child: (() {
                  if (destination == "galapagos") {
                    return Obx(() {
                      return CustomFormDropDownFieldWidget(
                        value: explorationMode.value,
                        onSaved: (value) {
                          explorationMode.value = value;
                        },
                        onChanged: (value) {
                          explorationMode.value = value;
                        },
                        label: "Exploration Mode   ",
                        data: processCatalog("exploration_mode"),
                      );
                    });
                  }
                })(),
              ),
              Obx(() {
                return CustomFormDropDownFieldWidget(
                  value: destinationOption.value,
                  onSaved: (value) {
                    destinationOption.value = value!;
                  },
                  onChanged: (value) {
                    destinationOption.value = value!;
                  },
                  label: "Destination Option",
                  data: processCatalog("destination_option"),
                );
              }),
              Obx(() {
                return CustomFormDropDownFieldWidget(
                  value: travelRhythm.value,
                  onSaved: (value) {
                    travelRhythm.value = value!;
                  },
                  onChanged: (value) {
                    travelRhythm.value = value!;
                  },
                  label: "Travel Rhythm         ",
                  data: processCatalog("travel_rhythm"),
                );
              }),
              Obx(() {
                return CustomFormMultiDropDownFieldWidget(
                  value: keyActivities.value,
                  onSaved: (value) {
                    print(value);
                    keyActivities.value = value!;
                  },
                  onChanged: (value) {
                    keyActivities.value = value!;
                  },
                  hintText: " ",
                  label: "Key Activities            ",
                  data: processCatalog("key_activity"),
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
