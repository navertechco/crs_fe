// ignore_for_file: prefer_function_declarations_over_variables, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naver_crs/common/index.dart';
import '../../../../index.dart';
import '../index.dart';

class CustomStarDestinationForm extends StatelessWidget {
  CustomStarDestinationForm({
    Key? key,
    required this.index,
    required this.destination,
    required this.ctrl,
    required this.formKey,
  }) : super(key: key);
  final String destination;
  final DestinationDetailController ctrl;
  GlobalKey<FormState> formKey;
  final index;

  @override
  Widget build(BuildContext context) {
    var tour = getContext("tour");
    var ctx = globalctx.context.value;
    var arrival_hour = findCatalog("arrival_hour");
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
        globalctx.memory["destinations"], index, "key_activities", <String>[]);
    Rx<String> subDestination =
        Rx(getFormValue(globalctx.memory["destinations"], index, "sub", "0"));
    List<Map<String, dynamic>> explorationdDays =
        findCatalog("exploration_days");

    Rx<List> trCatalog = Rx(findCatalog("travel_rhythm"));
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

    Function validateGalapagosTR = () {
      if (destination == "galapagos") {
        setFormValue(
            globalctx.memory["destinations"], index, "travel_rhythm", "3");
      }
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
                                ? Colors.yellow
                                : Colors.green,
                            fontSize: MediaQuery.of(context).size.width /
                                MediaQuery.of(context).size.height *
                                15,
                            fontWeight: FontWeight.bold,
                          ))),
                    ],
                  );
                }),
                Obx(() {
                  return Row(
                    children: [
                      Text("Selected Days: $accumulated",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            color: (accumulated.value) == 0
                                ? Colors.yellow
                                : Color.fromARGB(255, 0, 255, 0),
                            fontSize: MediaQuery.of(context).size.width /
                                MediaQuery.of(context).size.height *
                                15,
                            fontWeight: FontWeight.bold,
                          ))),
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
                        max: dayleft.value,
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
                SizedBox(
                  child: (() {
                    if (destination == "galapagos" || destination == "amazon") {
                      return Obx(() {
                        var expDay = explorationDay.value;
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
                          data: findCatalog("exploration_mode")
                              .where((element) =>
                                  element["relation"]["destination"] == null ||
                                  element["relation"]["destination"] ==
                                      destination)
                              .toList(),
                        );
                      });
                    }
                  })(),
                ),
                Obx(() {
                  var expDay = explorationDay.value;
                  if ((destination == "galapagos" &&
                          (explorationMode.value == "3" ||
                              explorationMode.value == "1")) ||
                      (destination != "galapagos" &&
                          (getSubs(destination).length > 0))) {
                    {
                      return CustomFormDropDownFieldWidget(
                        validator: CustomRequiredValidator(
                            errorText: "Sub Destination is required ",
                            ctx: context),
                        value: subDestination.value,
                        onSaved: (value) {
                          setFormValue(globalctx.memory["destinations"], index,
                              "sub", value);
                        },
                        onChanged: (value) {
                          setFormValue(globalctx.memory["destinations"], index,
                              "sub", value);
                        },
                        hintText: " ",
                        label: "${destination.capitalize} Subs     ",
                        data: getSubs(destination),
                      );
                    }
                  } else {
                    return Text("");
                  }
                }),
                SizedBox(child: Obx(() {
                  var expMode = explorationMode.value;
                  if (destination == "galapagos" &&
                      (explorationMode.value == "3" ||
                          explorationMode.value == "1")) {
                    return Column(
                      children: [
                        Obx(() {
                          return CustomFormCalendarFieldWidget(
                              label: "IH Range                    ",
                              initialStartDate: iHStartDate.value,
                              initialEndDate: iHEndDate.value,
                              minimumDate: firstDayDate.value,
                              maximumDate: iHEndDate.value,
                              startEndDateChange: (start, end) {
                                iHStartDate.value = start;
                                iHEndDate.value = end;
                                setFormValue(globalctx.memory["destinations"],
                                    index, "iHStartDate", start);
                                setFormValue(globalctx.memory["destinations"],
                                    index, "iHEndDate", end);
                              },
                              onSaved: () {
                                var val1 = iHEndDate.value
                                        .difference(iHStartDate.value)
                                        .inDays +
                                    1;
                                var val0 = int.parse(getFormValue(
                                    globalctx.memory["destinations"],
                                    index,
                                    "iHExpDays",
                                    "0"));

                                saveExplorationDays(index, val0, val1,
                                    key: "iHExpDays");
                                validateGalapagosTR();
                              });
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
                        Obx(
                          () {
                            return CustomFormCalendarFieldWidget(
                                label: "Cruise Range           ",
                                initialStartDate: cruiseStartDate.value,
                                initialEndDate: cruiseEndDate.value,
                                minimumDate: firstDayDate.value,
                                maximumDate: cruiseEndDate.value,
                                startEndDateChange: (start, end) {
                                  cruiseStartDate.value = start;
                                  cruiseEndDate.value = end;
                                },
                                onSaved: () {
                                  var start = cruiseStartDate.value;
                                  var end = cruiseEndDate.value;
                                  setFormValue(globalctx.memory["destinations"],
                                      index, "cruiseStartDate", start);
                                  setFormValue(globalctx.memory["destinations"],
                                      index, "cruiseEndDate", end);

                                  var val1 = cruiseEndDate.value
                                          .difference(cruiseStartDate.value)
                                          .inDays +
                                      1;
                                  var val0 = int.parse(getFormValue(
                                      globalctx.memory["destinations"],
                                      index,
                                      "cruiseExpDays",
                                      "0"));

                                  saveExplorationDays(index, val0, val1,
                                      key: "cruiseExpDays");
                                  validateGalapagosTR();
                                });
                          },
                        )
                      ],
                    );
                  }
                  return Text("");
                })),
                Obx(() {
                  var expMode = explorationMode.value;
                  if (type == "arrival") {
                    return CustomFormDropDownFieldWidget(
                        validator: CustomRequiredValidator(
                            errorText: "Arrival Hour is required ",
                            ctx: context),
                        value: getFormValue(globalctx.memory["destinations"],
                            index, "arrival_hour", "0"),
                        onSaved: (value) {
                          setFormValue(globalctx.memory["destinations"], index,
                              "arrival_hour", value);
                          arrivalHour.value = filterCatalog(
                                  "arrival_hour", "code", int.parse(value!))[0]
                              ["description"];
                        },
                        onChanged: (value) {
                          setFormValue(globalctx.memory["destinations"], index,
                              "arrival_hour", value);
                          arrivalHour.value = filterCatalog(
                                  "arrival_hour", "code", int.parse(value!))[0]
                              ["description"];
                        },
                        label: "Arrival Hour              ",
                        data: arrival_hour);
                  }
                  return Text("");
                }),
                Obx(() {
                  var expMode = explorationMode.value;
                  if (explorationMode.value != "2") {
                    return CustomFormDropDownFieldWidget(
                        disabled: type == "arrival" ||
                            type == "departure" ||
                            explorationMode.value != "0" ||
                            destination == "galapagos",
                        validator: CustomRequiredValidator(
                            errorText: "Travel Rhythm is required ",
                            ctx: context),
                        value: getFormValue(
                            globalctx.memory["destinations"],
                            index,
                            "travel_rhythm",
                            destination == "galapagos" ? "3" : "1"),
                        onSaved: (value) {
                          setFormValue(
                              globalctx.memory["destinations"],
                              index,
                              "travel_rhythm",
                              destination == "galapagos" ? "3" : value);
                          setFormValue(globalctx.memory["destinations"], index,
                              "type", type);
                          setFormValue(globalctx.memory["destinations"], index,
                              "index", index);
                          setFormValue(globalctx.memory["destinations"], index,
                              "destination", destination);
                        },
                        onChanged: (value) {
                          setFormValue(
                              globalctx.memory["destinations"],
                              index,
                              "travel_rhythm",
                              destination == "galapagos" ? "3" : value);
                        },
                        label: "Travel Rhythm         ",
                        data: findCatalog("travel_rhythm"));
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
                      onSaved: (values) {
                        if (values == null) return;
                        if (values.length > 3) {
                          Get.snackbar("Error", "You can select maximum 3 ka",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                              borderRadius: 10,
                              margin: EdgeInsets.all(10),
                              duration: Duration(seconds: 3));
                          return;
                        }
                        if (values.length <= 3) {
                          kaMemory.value = [];
                          var length = values.length;

                          for (var i = 0; i < length; i++) {
                            kaMemory.value.add(findCatalog("key_activity")
                                .toList()
                                .where((e) => e["code"] == values[i])
                                .toList()[0]["description"]);
                          }
                          setFormValue(globalctx.memory["destinations"], index,
                              "key_activities", kaMemory.value);
                        }
                      },
                      onChanged: (value) {
                        setFormValue(globalctx.memory["destinations"], index,
                            "key_activities", value);
                      },
                      hintText: " ",
                      label: "Key Activities            ",
                      data: findCatalog("key_activity"),
                    );
                  }
                  return Text("");
                }),
                Obx(() {
                  var expMode = explorationMode.value;
                  if (index == 0) {
                    return CustomFormCheckboxWidget(
                      label: "Arrival Dinner          ",
                      value: 1,
                      groupValue: arrivalDinner,
                      onChanged: (value) {
                        arrivalDinner.value = value;
                        setFormValue(
                            globalctx.memory, "logistic", "dinner", value);
                      },
                    );
                  } else {
                    return Text("");
                  }
                })
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
