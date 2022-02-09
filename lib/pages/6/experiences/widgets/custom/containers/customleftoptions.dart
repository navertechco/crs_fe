import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

import '../../../../../index.dart';

class CustomLeftOptionsWidget extends HookWidget {
  final ExperiencesController ctrl;
  final ValueNotifier<int> counter;
  CustomLeftOptionsWidget({
    Key? key,
    required this.ctrl,
    required this.counter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ctrl.state.memory = globalctx.memory;
    Rx<dynamic> transportService = Rx(getFormValue(
            ctrl.state.memory, destination.value, "service_type", <String>[]) ??
        <String>[]);
    Rx<dynamic> translatingService = Rx(getFormValue(ctrl.state.memory,
        destination.value, "translating_service", <String>[]));
    Rx<dynamic> keyActivities = Rx(getFormValue(
        ctrl.state.memory["destinations"],
        destination.value,
        "key_activities", <String>[]));

    Rx<int> guide =
        Rx(getFormValue(ctrl.state.memory, destination.value, "guide_type", 1));

    Rx<int> guideIndex = Rx(
        transportService.value.indexWhere((element) => element == "GUIDING") ??
            0);
    Rx<int> translateIndex = Rx(transportService.value
            .indexWhere((element) => element == "TRANSLATING") ??
        0);

    Rx<dynamic> destinationOption = Rx(getFormValue(
        ctrl.state.memory, destination.value, "destinationOption", "0"));

    Rx<dynamic> travelRhythm = Rx(getFormValue(
        ctrl.state.memory, destination.value, "travel_rhythm", "0"));

    useEffect(() {
      print("INNER LEFT RENDER");
      setFormValue(
          ctrl.state.memory, destination.value, "destinationOption", "0");
      setFormValue(ctrl.state.memory, destination.value, "travel_rhythm", "0");
      destinationOption.value = getFormValue(
          ctrl.state.memory, destination.value, "destinationOption", "0");
      travelRhythm.value = getFormValue(
          ctrl.state.memory, destination.value, "travel_rhythm", "0");
    }, [stream, counter.value]);

    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.3,
          left: MediaQuery.of(context).size.width * 0.05),
      child: Column(
        children: [
          Obx(() {
            var destination = processDays(currentDay)["destination"];
            var add = 1;
            var day = currentDay.value + add;
            if (destination == "departure") {
              add = 0;
            }
            if (currentDay.value == 1) {
              add = 0;
            }
            if (day > 1) {
              day -= 1;
            }

            return CustomTitleWidget(
              fontWeight: FontWeight.bold,
              label: "Day : ${day}  ${destination.toString().capitalize}",
            );
          }),
          Divider(color: Color.fromARGB(255, 0, 0, 0)),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Scrollbar(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: [
                        CustomTitleWidget(
                          fontWeight: FontWeight.bold,
                          label: "Day Transport Options:",
                        ),
                        CustomTitleWidget(
                          fontWeight: FontWeight.bold,
                          label: "______________________",
                        ),
                      ],
                    ),
                    Obx(() {
                      return Column(
                        children: [
                          CustomFormMultiDropDownFieldWidget(
                            // label: "Exploration Days",
                            value: getFormValue(ctrl.state.memory,
                                destination.value, "service_type", <String>[]),
                            onSaved: (value) {
                              transportService.value = value;
                              guideIndex.value = transportService.value
                                  .indexWhere(
                                      (element) => element == "GUIDING");
                              translateIndex.value = transportService.value
                                  .indexWhere(
                                      (element) => element == "TRANSLATING");
                              setFormValue(ctrl.state.memory, destination.value,
                                  "service_type", value);
                            },
                            onChanged: (value) {
                              transportService.value = value;
                              guideIndex.value = transportService.value
                                  .indexWhere(
                                      (element) => element == "GUIDING");
                              translateIndex.value = transportService.value
                                  .indexWhere(
                                      (element) => element == "TRANSLATING");
                              setFormValue(ctrl.state.memory, destination.value,
                                  "service_type", value);
                            },
                            hintText: "                  Services\n",
                            data: processCatalog("service_type"),
                          ),
                          if (translateIndex.value != -1)
                            CustomFormMultiDropDownFieldWidget(
                              // label: "Exploration Days",
                              value: translatingService.value,
                              onSaved: (value) {
                                setFormValue(
                                    ctrl.state.memory,
                                    destination.value,
                                    "translating_service",
                                    value);
                              },
                              onChanged: (value) {
                                translateIndex.value =
                                    value!.isNotEmpty ? 0 : -1;
                                translatingService.value = value;
                                setFormValue(
                                    ctrl.state.memory,
                                    destination.value,
                                    "translating_service",
                                    value);
                              },
                              hintText: "          Translating Services",
                              data: processCatalog("translating_service"),
                            ),
                          if (guideIndex.value != -1)
                            Column(
                              children: [
                                CustomFormCheckboxWidget(
                                  value: 1,
                                  groupValue: guide,
                                  onChanged: (value) {
                                    if (guide.value == value) {
                                      guide.value = 0;
                                    } else {
                                      guide.value = value;
                                      setFormValue(
                                          ctrl.state.memory,
                                          destination.value,
                                          "guide_type",
                                          value);
                                    }
                                  },
                                  hintText: "Driver guide?",
                                ),
                                CustomFormCheckboxWidget(
                                  value: 2,
                                  groupValue: guide,
                                  onChanged: (value) {
                                    if (guide.value == value) {
                                      guide.value = 0;
                                    } else {
                                      guide.value = value;
                                      setFormValue(
                                          ctrl.state.memory,
                                          destination.value,
                                          "guide_type",
                                          value);
                                    }
                                  },
                                  hintText: "Additional guide?",
                                ),
                              ],
                            )
                        ],
                      );
                    }),
                    Column(
                      children: [
                        CustomTitleWidget(
                          fontWeight: FontWeight.bold,
                          label: "Filter Experiences by:",
                        ),
                        CustomTitleWidget(
                          fontWeight: FontWeight.bold,
                          label: "______________________",
                        ),
                      ],
                    ),
                    Obx(() {
                      return CustomFormDropDownFieldWidget(
                        // label: "Exploration Days",
                        value: destinationOption.value,
                        onSaved: (value) {
                          setFormValue(ctrl.state.memory, destination.value,
                              "destinationOption", value);
                        },
                        onChanged: (value) {
                          setFormValue(ctrl.state.memory, destination.value,
                              "destinationOption", value);
                        },
                        hintText: "Travel Options",
                        data: processCatalog("destination_option"),
                      );
                    }),
                    Obx(() {
                      return CustomFormDropDownFieldWidget(
                        // label: "Exploration Days",
                        value: travelRhythm.value,
                        onSaved: (value) {
                          setFormValue(ctrl.state.memory, destination.value,
                              "travel_rhythm", value);
                        },
                        onChanged: (value) {
                          setFormValue(ctrl.state.memory, destination.value,
                              "travel_rhythm", value);
                        },
                        hintText: "Travel Rhythm",
                        data: processCatalog("travel_rhythm"),
                      );
                    }),
                    Obx(() {
                      return CustomFormMultiDropDownFieldWidget(
                        validator: (value) =>
                            CustomMultiDropdownRequiredValidator(value,
                                errorText: "Key Activities are required ",
                                context: context),
                        value: keyActivities.value,
                        onSaved: (value) {
                          setFormValue(ctrl.state.memory["destinations"],
                              destination.value, "keyActivities", null);
                          setFormValue(
                              ctrl.state.memory["destinations"],
                              destination.value,
                              "keyActivities",
                              value!
                                  .map((e) => e["description"])
                                  .toSet()
                                  .toList());
                        },
                        onChanged: (value) {
                          setFormValue(globalctx.memory["destinations"],
                              destination.value, "keyActivities", value);
                          ctrl.state.memory = globalctx.memory;
                        },
                        hintText:
                            "\t\t\t\t\t\t\t\t\t\t\t\tKey Activities            \n",
                        data: processCatalog("key_activity"),
                      );
                    }),
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
