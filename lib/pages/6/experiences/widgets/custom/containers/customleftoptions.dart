import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../index.dart';

class CustomLeftOptionsWidget extends StatelessWidget {
  const CustomLeftOptionsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Rx<int> currentDay = 0.obs;

    Rx<String> destination = Rx(globalctx.promoted.value[currentDay.value]);
    Rx<Map<dynamic, dynamic>> localdata =
        Rx(globalctx.context.value["experiencedata"]);
    Rx<dynamic> transportService = Rx(getFormValue(
        globalctx.memory["experiences"],
        destination,
        "service_type", <String>[]));

    Rx<int> guide = Rx(getFormValue(
        globalctx.memory["experiences"], destination, "guide_type", 1));

    Rx<DateTime> arrivalDate = Rx(globalctx.memory["tour"]["arrival_date"]);
    Rx<DateTime> departureDate = Rx(globalctx.memory["tour"]["departure_date"]);
    Rx<int> totalDays =
        Rx(departureDate.value.difference(arrivalDate.value).inDays);
    Rx<int> guideIndex = Rx(
        transportService.value.indexWhere((element) => element == "GUIDING"));
    Rx<int> translateIndex = Rx(transportService.value
        .indexWhere((element) => element == "TRANSLATING"));
    Rx<List<String>> translatingService = Rx(
      getFormValue(globalctx.memory["experiences"], destination,
          "translating_service", <String>[]),
    );
    Rx<List<String>> keyActivies = Rx(
      getFormValue(globalctx.memory["experiences"], destination,
          "key_activities", <String>[]),
    );
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
                            value: getFormValue(globalctx.memory["experiences"],
                                destination, "service_type", <String>[]),
                            onSaved: (value) {
                              transportService.value = value;
                              guideIndex.value = transportService.value
                                  .indexWhere(
                                      (element) => element == "GUIDING");
                              translateIndex.value = transportService.value
                                  .indexWhere(
                                      (element) => element == "TRANSLATING");
                              setFormValue(globalctx.memory["experiences"],
                                  destination, "service_type", value);
                            },
                            onChanged: (value) {
                              transportService.value = value;
                              guideIndex.value = transportService.value
                                  .indexWhere(
                                      (element) => element == "GUIDING");
                              translateIndex.value = transportService.value
                                  .indexWhere(
                                      (element) => element == "TRANSLATING");
                              setFormValue(globalctx.memory["experiences"],
                                  destination, "service_type", value);
                            },
                            hintText: "                  Services",
                            data: processCatalog("service_type"),
                          ),
                          if (translateIndex.value != -1)
                            CustomFormMultiDropDownFieldWidget(
                              // label: "Exploration Days",
                              value: translatingService.value,
                              onSaved: (value) {
                                setFormValue(globalctx.memory["experiences"],
                                    destination, "translating_service", value);
                              },
                              onChanged: (value) {
                                translateIndex.value =
                                    value!.isNotEmpty ? 0 : -1;
                                translatingService.value = value;
                                setFormValue(globalctx.memory["experiences"],
                                    destination, "translating_service", value);
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
                                          globalctx.memory["experiences"],
                                          destination,
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
                                          globalctx.memory["experiences"],
                                          destination,
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
                    CustomFormDropDownFieldWidget(
                      // label: "Exploration Days",
                      value: getFormValue(globalctx.memory["experiences"],
                          destination, "destination_option", "0"),
                      onSaved: (value) {
                        setFormValue(globalctx.memory["experiences"],
                            destination, "destination_option", value);
                      },
                      onChanged: (value) {
                        setFormValue(globalctx.memory["experiences"],
                            destination, "destination_option", value);
                      },
                      hintText: "Travel Options",
                      data: processCatalog("destination_option"),
                    ),
                    CustomFormMultiDropDownFieldWidget(
                      value: keyActivies.value,
                      onSaved: (value) {
                        setFormValue(globalctx.memory["experiences"],
                            destination, "key_activities", value);
                      },
                      onChanged: (value) {
                        keyActivies.value = value!;
                        setFormValue(globalctx.memory["experiences"],
                            destination, "key_activities", value);
                      },
                      hintText: "Key Activities            ",
                      data: processCatalog("key_activity"),
                    ),
                    CustomFormDropDownFieldWidget(
                      // label: "Exploration Days",
                      value: getFormValue(globalctx.memory["experiences"],
                          destination, "travel_rhythm", "0"),
                      onSaved: (value) {
                        setFormValue(globalctx.memory["experiences"],
                            destination, "travel_rhythm", value);
                      },
                      onChanged: (value) {
                        setFormValue(globalctx.memory["experiences"],
                            destination, "travel_rhythm", value);
                      },
                      hintText: "Travel Rhythm",
                      data: processCatalog("travel_rhythm"),
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
