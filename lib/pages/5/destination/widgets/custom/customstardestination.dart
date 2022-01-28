// ignore_for_file: prefer_function_declarations_over_variables, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naver_crs/pages/5/destination/widgets/destinationdetail/controller.dart';
import '../../../../index.dart';

class CustomStarDestinationForm extends StatelessWidget {
  CustomStarDestinationForm({
    Key? key,
    required this.destination,
    required this.ctrl,
    required this.formKey,
  }) : super(key: key);
  final String destination;
  final DestinationDetailController ctrl;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    var tour = getContext("tour");
    var ctx = globalctx.context.value;
    var destinationData = getParam("DESTINATION_DATA");
    Map<dynamic, dynamic> destinations = getValue(destinationData, "value");
    Rx<DateTime> arrivalDate = Rx(globalctx.memory["tour"]["arrival_date"]);
    Rx<DateTime> departureDate = Rx(globalctx.memory["tour"]["departure_date"]);
    Rx<int> totalDays =
        Rx(departureDate.value.difference(arrivalDate.value).inDays);
    Rx<int> memoryDayLeft = Rx(globalctx.memory["days_left"].value);
    Rx<int> daysLeft = Rx(-memoryDayLeft.value + totalDays.value);
    Rx<int> explorationDay = Rx(int.parse(
        getFormValue(ctrl.state.memory, destination, "explorationDay", "1")));

    Rx<int> leftAccumulated = 0.obs;
    if (globalctx.reset.value) {
      for (var item in destinations.keys) {
        ctrl.state.memory[item] = null;
      }
      globalctx.reset.value = false;
    }
    for (var item in destinations.keys) {
      bool exists = ctrl.state.memory[item] != null && item != destination;
      if (exists) {
        leftAccumulated.value -= int.parse(
            getFormValue(ctrl.state.memory, item, "explorationDay", "1"));
      }
    }

    print(globalctx.memory);
    return Form(
      key: formKey,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05,
                top: MediaQuery.of(context).size.height * 0.1),
            child: SizedBox(
              child: Column(children: [
                Obx(() {
                  return Row(
                    children: [
                      Text(
                          "Days Left: ${totalDays.value + leftAccumulated.value - explorationDay.value}",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            color: (totalDays.value +
                                        leftAccumulated.value -
                                        explorationDay.value) <
                                    1
                                ? Color.fromARGB(255, 255, 0, 0)
                                : Color.fromARGB(255, 0, 0, 0),
                            fontSize: MediaQuery.of(context).size.width /
                                MediaQuery.of(context).size.height *
                                10,
                            fontWeight: FontWeight.bold,
                          ))),
                    ],
                  );
                }),
                CustomTitleWidget(
                  width: 0.2,
                  fontWeight: FontWeight.bold,
                  label: destinations[destination][1],
                ),
                Obx(() {
                  return CustomFormDropDownFieldWidget(
                    validator: CustomRequiredValidator(
                        errorText: "Exploration Days is required ",
                        ctx: context),
                    value: getFormValue(
                        ctrl.state.memory, destination, "explorationDay", "1"),
                    onSaved: (value) {
                      setFormValue(ctrl.state.memory, destination,
                          "explorationDay", value);
                    },
                    onChanged: (value) {
                      setFormValue(ctrl.state.memory, destination,
                          "explorationDay", value);
                      explorationDay.value = int.parse(value!);
                      daysLeft.value = totalDays.value - explorationDay.value;
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
                          validator: CustomRequiredValidator(
                              errorText: "Exploration mode is required ",
                              ctx: context),
                          value: getFormValue(ctrl.state.memory, destination,
                              "explorationMode", "0"),
                          onSaved: (value) {
                            setFormValue(ctrl.state.memory, destination,
                                "explorationMode", value);
                            globalctx.memory["days_left"].value -= int.parse(
                                getFormValue(ctrl.state.memory, destination,
                                    "explorationDay", "1"));
                          },
                          onChanged: (value) {
                            setFormValue(ctrl.state.memory, destination,
                                "explorationMode", value);
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
                    validator: CustomRequiredValidator(
                        errorText: "Destination option is required ",
                        ctx: context),
                    value: getFormValue(ctrl.state.memory, destination,
                        "destinationOption", "0"),
                    onSaved: (value) {
                      setFormValue(ctrl.state.memory, destination,
                          "destinationOption", value);
                    },
                    onChanged: (value) {
                      setFormValue(ctrl.state.memory, destination,
                          "destinationOption", value);
                    },
                    label: "Destination Option",
                    data: processCatalog("destination_option"),
                  );
                }),
                Obx(() {
                  return CustomFormDropDownFieldWidget(
                    validator: CustomRequiredValidator(
                        errorText: "Travel Rhythm is required ", ctx: context),
                    value: getFormValue(
                        ctrl.state.memory, destination, "travelRhythm", "0"),
                    onSaved: (value) {
                      setFormValue(ctrl.state.memory, destination,
                          "travelRhythm", value);
                    },
                    onChanged: (value) {
                      setFormValue(ctrl.state.memory, destination,
                          "travelRhythm", value);
                    },
                    label: "Travel Rhythm         ",
                    data: processCatalog("travel_rhythm"),
                  );
                }),
                Obx(() {
                  return CustomFormMultiDropDownFieldWidget(
                    validator: (value) => CustomMultiDropdownRequiredValidator(
                        value,
                        errorText: "Key Activities are required ",
                        context: context),
                    value: getFormValue(ctrl.state.memory, destination,
                        "keyActivities", multiDefault),
                    onSaved: (value) {
                      setFormValue(ctrl.state.memory, destination,
                          "keyActivities", null);
                      setFormValue(
                          ctrl.state.memory,
                          destination,
                          "keyActivities",
                          value!.map((e) => e["description"]).toSet().toList());
                    },
                    onChanged: (value) {
                      setFormValue(ctrl.state.memory, destination,
                          "keyActivities", value);
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
      ),
    );
  }
}
