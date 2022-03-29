// ignore_for_file: prefer_function_declarations_over_variables, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naver_crs/common/index.dart';
import '../../../../index.dart';
import '../index.dart';

class CustomStarDestinationForm extends StatelessWidget {
  const CustomStarDestinationForm({
    Key? key,
    required this.index,
    required this.destination,
    required this.ctrl,
    required this.formKey,
  }) : super(key: key);
  final String destination;
  final DestinationDetailController ctrl;
  final GlobalKey<FormState> formKey;
  final index;

  @override
  Widget build(BuildContext context) {
    var tour = getContext("tour");
    var ctx = globalctx.context.value;

    Rx<int> explorationDay = Rx(int.parse(getFormValue(
            globalctx.memory["destinations"], index, "explorationDay", "0") ??
        "0"));

    if (globalctx.reset.value) {
      for (String item in destinations.keys) {
        globalctx.memory["destinations"][item] = null;
      }
      globalctx.reset.value = false;
    }

    List<String> keyActivities = getFormValue(
        globalctx.memory["destinations"], index, "keyActivities", <String>[]);
    Rx<String> subs =
        Rx(getFormValue(globalctx.memory["destinations"], index, "subs", "0"));
    List<Map<String, dynamic>> explorationdDays =
        processCatalog("exploration_days");

    Rx<List> trCatalog = Rx(processCatalog("travel_rhythm"));
    var destData = globalctx.memory["destinations"][index.toString()];
    var type = globalctx.states["destinations"][index]["type"];
    RxString explorationMode = getFormValue(
            globalctx.memory["destinations"], index, "explorationMode", "0")
        .toString()
        .obs;
    RxString cruiseOptions = getFormValue(
            globalctx.memory["destinations"], index, "cruiseOptions", "0")
        .toString()
        .obs;
    RxInt minExpDay = (explorationMode.value == "1"
            ? 2
            : explorationMode.value == "2"
                ? 4
                : 0)
        .obs;

    Function validateMixedDate =
        (DateTime memoryDate, DateTime compareDate, DateTime currentDate) {
      if (compareDate == memoryDate ||
          currentDate.isBefore(compareDate) ||
          currentDate.isAfter(compareDate)) {
        return currentDate;
      }
      return compareDate;
    };

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
                      Text("Remaining Days: $dayleft",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            color: (dayleft.value) < 1
                                ? Color.fromARGB(255, 255, 0, 0)
                                : Color.fromARGB(255, 0, 0, 0),
                            fontSize: MediaQuery.of(context).size.width /
                                MediaQuery.of(context).size.height *
                                10,
                            fontWeight: FontWeight.bold,
                          )))
                    ],
                  );
                }),
                Obx(() {
                  return Row(
                    children: [
                      Text("   Selected Days: $accumulated",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            color: (accumulated.value) == 0
                                ? Color.fromARGB(255, 255, 0, 0)
                                : Color.fromARGB(255, 0, 255, 0),
                            fontSize: MediaQuery.of(context).size.width /
                                MediaQuery.of(context).size.height *
                                10,
                            fontWeight: FontWeight.bold,
                          )))
                    ],
                  );
                }),
                CustomTitleWidget(
                  width: 0.2,
                  fontWeight: FontWeight.bold,
                  label: "Destination: ${destination.capitalize}",
                ),
                CustomTitleWidget(
                  width: 0.2,
                  fontWeight: FontWeight.bold,
                  label: "Index: $index",
                ),
                CustomTitleWidget(
                  width: 0.2,
                  fontWeight: FontWeight.bold,
                  label: "Type: ${type.toString().capitalize}",
                ),
                Obx(() {
                  var expDay = explorationDay.value;
                  if (destination != "galapagos") {
                    return CustomFormCounterFieldWidget(
                        initial: int.parse(getFormValue(
                            globalctx.memory["destinations"],
                            index,
                            "explorationDay",
                            "0")),
                        min: 0,
                        max: totalDays.value,
                        bound: 0,
                        onValueChanged: (value) {
                          saveExplorationDays(
                              index,
                              int.parse(getFormValue(
                                  globalctx.memory["destinations"],
                                  index,
                                  "explorationDay",
                                  "0")),
                              value as int);
                        },
                        label: "Exploration Days    ",
                        width: 0.20);
                  }
                  return Text("");
                }),
                Obx(() {
                  var expDay = explorationDay.value;
                  if (getSubs(destination).length > 0) {
                    return CustomFormDropDownFieldWidget(
                      validator: CustomRequiredValidator(
                          errorText: "subs is required ", ctx: context),
                      value: subs.value,
                      onSaved: (value) {
                        setFormValue(globalctx.memory["destinations"], index,
                            "subs", value);
                      },
                      onChanged: (value) {
                        setFormValue(globalctx.memory["destinations"], index,
                            "subs", value);
                        explorationMode.value = value!;
                      },
                      hintText: " ",
                      label: "${destination.capitalize} Subs      ",
                      data: getSubs(destination),
                    );
                  }
                  return Text("");
                }),
                SizedBox(
                  child: (() {
                    if (destination == "galapagos" || destination == "amazon") {
                      return Obx(() {
                        return CustomFormDropDownFieldWidget(
                          validator: CustomRequiredValidator(
                              errorText: "Exploration mode is required ",
                              ctx: context),
                          value: explorationMode.value,
                          onSaved: (value) {
                            setFormValue(globalctx.memory["destinations"],
                                index, "explorationMode", value);
                          },
                          onChanged: (value) {
                            setFormValue(globalctx.memory["destinations"],
                                index, "explorationMode", value);
                            explorationMode.value = value!;
                          },
                          label: "Exploration Mode    ",
                          data: processCatalog("exploration_mode"),
                        );
                      });
                    }
                  })(),
                ),
                SizedBox(child: Obx(() {
                  var expMode = explorationMode.value;
                  if (destination == "galapagos" &&
                      (explorationMode.value == "3" ||
                          explorationMode.value == "1")) {
                    return Column(
                      children: [
                        // CustomFormCounterFieldWidget(
                        //     initial: int.parse(getFormValue(
                        //         globalctx.memory["destinations"],
                        //         index,
                        //         "ihExplorationDay",
                        //         "2")),
                        //     min: 2,
                        //     max: totalDays.value,
                        //     bound: 2,
                        //     onValueChanged: (value) {
                        //       saveExplorationDays(
                        //           index,
                        //           int.parse(getFormValue(
                        //               globalctx.memory["destinations"],
                        //               index,
                        //               "ihExplorationDay",
                        //               "2")),
                        //           value as int);
                        //     },
                        //     label: "IH Exploration Days",
                        //     width: 0.20),
                        Obx(() {
                          return CustomFormCalendarFieldWidget(
                            label: "IH Range                    ",
                            initialStartDate: validateMixedDate(
                                penultimateDayDate.value,
                                cruiseEndDate.value,
                                iHStartDate.value),
                            initialEndDate: iHEndDate.value,
                            minimumDate: validateMixedDate(
                                penultimateDayDate.value,
                                cruiseEndDate.value,
                                iHStartDate.value),
                            maximumDate: iHEndDate.value,
                            startEndDateChange: (start, end) {
                              iHStartDate.value = start;
                              iHEndDate.value = end;
                              var value = iHEndDate.value
                                      .difference(iHStartDate.value)
                                      .inDays +
                                  1;
                              var mem = int.parse(getFormValue(
                                  globalctx.memory["destinations"],
                                  index,
                                  "iHExpDays",
                                  "0"));
                              saveExplorationDays(index, mem, value,
                                  key: "iHExpDays");
                            },
                          );
                        }),
                      ],
                    );
                  }
                  return Text("");
                })),
                SizedBox(child: Obx(() {
                  var expMode = explorationMode.value;
                  if (destination == "galapagos" &&
                      (explorationMode.value == "3" ||
                          explorationMode.value == "2")) {
                    return Column(
                      children: [
                        // CustomFormCounterFieldWidget(
                        //     initial: int.parse(getFormValue(
                        //         globalctx.memory["destinations"],
                        //         index,
                        //         "cExplorationDay",
                        //         "4")),
                        //     min: 4,
                        //     max: totalDays.value,
                        //     bound: 4,
                        //     onValueChanged: (value) {
                        //       saveExplorationDays(
                        //           index,
                        //           int.parse(getFormValue(
                        //               globalctx.memory["destinations"],
                        //               index,
                        //               "cExplorationDay",
                        //               "4")),
                        //           value as int);
                        //     },
                        //     label: "Cruise Exp. Days      ",
                        //     width: 0.20),
                        Obx(
                          () {
                            return CustomFormCalendarFieldWidget(
                              label: "Cruise Range           ",
                              initialStartDate: validateMixedDate(
                                  penultimateDayDate.value,
                                  iHEndDate.value,
                                  cruiseStartDate.value),
                              initialEndDate: cruiseEndDate.value,
                              minimumDate: validateMixedDate(
                                  penultimateDayDate.value,
                                  iHEndDate.value,
                                  cruiseStartDate.value),
                              maximumDate: cruiseEndDate.value,
                              startEndDateChange: (start, end) {
                                cruiseStartDate.value = start;
                                cruiseEndDate.value = end;
                                var value = cruiseEndDate.value
                                        .difference(cruiseStartDate.value)
                                        .inDays +
                                    1;

                                var mem = int.parse(getFormValue(
                                    globalctx.memory["destinations"],
                                    index,
                                    "cruiseExpDays",
                                    "0"));
                                saveExplorationDays(index, mem, value,
                                    key: "cruiseExpDays");
                              },
                            );
                          },
                        )
                      ],
                    );
                  }
                  return Text("");
                })),
                Obx(() {
                  var expMode = explorationMode.value;
                  if (explorationMode.value != "2") {
                    return CustomFormDropDownFieldWidget(
                        disabled:
                            type == "arrival" || explorationMode.value != "0",
                        validator: CustomRequiredValidator(
                            errorText: "Travel Rhythm is required ",
                            ctx: context),
                        value: getFormValue(
                            globalctx.memory["destinations"],
                            index,
                            "travelRhythm",
                            explorationMode.value == "0" ? "1" : "3"),
                        onSaved: (value) {
                          setFormValue(globalctx.memory["destinations"], index,
                              "travelRhythm", value);
                          setFormValue(globalctx.memory["destinations"], index,
                              "type", type);
                          setFormValue(globalctx.memory["destinations"], index,
                              "index", index);
                          setFormValue(globalctx.memory["destinations"], index,
                              "destination", destination);
                        },
                        onChanged: (value) {
                          setFormValue(globalctx.memory["destinations"], index,
                              "travelRhythm", value);
                        },
                        label: "Travel Rhythm         ",
                        data: multiDropDownKaAgeFilter(
                            trCatalog, travelRhytmAges));
                  }
                  return Text("");
                }),
                Obx(() {
                  if (explorationMode.value != "2") {
                    return CustomFormMultiDropDownFieldWidget(
                      validator: (value) =>
                          CustomMultiDropdownRequiredValidator(value,
                              errorText: "Key Activities are required ",
                              context: context),
                      value: keyActivities,
                      onSaved: (value) {
                        setFormValue(globalctx.memory["destinations"], index,
                            "keyActivities", ["CULTURE"]);
                        setFormValue(
                            globalctx.memory["destinations"],
                            index,
                            "keyActivities",
                            value!
                                .map((e) => e["description"])
                                .toSet()
                                .toList());
                      },
                      onChanged: (value) {
                        setFormValue(globalctx.memory["destinations"], index,
                            "keyActivities", value);
                      },
                      hintText: " ",
                      label: "Key Activities            ",
                      data: processCatalog("key_activity"),
                    );
                  }
                  return Text("");
                }),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
