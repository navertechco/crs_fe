// ignore_for_file: prefer_function_declarations_over_variables, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naver_crs/common/validators.dart';
import 'package:naver_crs/pages/5/destination/widgets/destinationdetail/controller.dart';
import '../../../../index.dart';

class CustomStarDestinationForm extends StatelessWidget {
  const CustomStarDestinationForm({
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

    Rx<int> explorationDay = Rx(int.parse(
        getFormValue(globalctx.memory["destinations"], destination, "explorationDay", "0") ??
            "0"));

    if (globalctx.reset.value) {
      for (String item in destinations.keys) {
        globalctx.memory["destinations"][item] = null;
      }
      globalctx.reset.value = false;
    }

    var acc = getLeftAccumulated("");
    dayleft.value = totalDays.value + leftAccumulated.value;

    List<String> keyActivities = getFormValue(
        globalctx.memory["destinations"], destination, "keyActivities", <String>[]);

    List<Map<String, dynamic>> explorationdDays =
        processCatalog("exploration_days");

    Rx<List> trCatalog = Rx(processCatalog("travel_rhythm"));
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
                      Text("Days Left: $dayleft",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            color: (dayleft.value) < 1
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
                  label: destination,
                ),
                Obx(() {
                  Rx<List<Map<String, dynamic>>> filteredED = Rx(
                      explorationdDays
                          .where((e) => e["code"] <= totalDays.value)
                          .toList());
                  return CustomFormTextFieldWidget(
                      value: getFormValue(globalctx.memory["destinations"], destination,
                          "explorationDay", "0"),
                      validator: CustomRequiredValidator(
                          errorText: "Exploration Days required ",
                          ctx: context),
                      onSaved: (value) {
                        setContext("dayleft", dayleft.value);
                      },
                      onChanged: (value) {
                        int valueInt = parseIntValue(value);
                        if (valueInt <= dayleft.value) {
                          value = valueInt.toString();
                          if (valueInt > dayleft.value) {
                            value = dayleft.value.toString();
                            valueInt = parseIntValue(value);
                          }
                          int acc = getLeftAccumulated(destination);
                          dayleft.value = totalDays.value + acc - valueInt;
                          setFormValue(globalctx.memory["destinations"], destination,
                              "explorationDay", value);
                          setFormValue(globalctx.memory, destination,
                              "explorationDay", value);
                          explorationDay.value = valueInt;
                          setDestinationDay(destination, value);
                        }
                      },
                      keyboardType: TextInputType.number,
                      label: "Exploration Days    ",
                      width: 0.20);
                }),
                SizedBox(
                  child: (() {
                    if (destination == "galapagos" || destination == "amazon") {
                      return Obx(() {
                        return CustomFormDropDownFieldWidget(
                          validator: CustomRequiredValidator(
                              errorText: "Exploration mode is required ",
                              ctx: context),
                          value: getFormValue(globalctx.memory["destinations"], destination,
                              "explorationMode", "0"),
                          onSaved: (value) {
                            setFormValue(globalctx.memory["destinations"], destination,
                                "explorationMode", value);
                            
                          },
                          onChanged: (value) {
                            setFormValue(globalctx.memory["destinations"], destination,
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
                    value: getFormValue(globalctx.memory["destinations"], destination,
                        "destinationOption", "1"),
                    onSaved: (value) {
                      setFormValue(globalctx.memory["destinations"], destination,
                          "destinationOption", value);
                    },
                    onChanged: (value) {
                      setFormValue(globalctx.memory["destinations"], destination,
                          "destinationOption", value);
                    },
                    label: "Destination Option",
                    data: processCatalog("destination_option"),
                  );
                }),
                Obx(() {
                  return CustomFormDropDownFieldWidget(
                      validator: CustomRequiredValidator(
                          errorText: "Travel Rhythm is required ",
                          ctx: context),
                      value: getFormValue(
                          globalctx.memory["destinations"], destination, "travelRhythm", "1"),
                      onSaved: (value) {
                        setFormValue(globalctx.memory["destinations"], destination,
                            "travelRhythm", value);
                      },
                      onChanged: (value) {
                        setFormValue(globalctx.memory["destinations"], destination,
                            "travelRhythm", value);
                      },
                      label: "Travel Rhythm         ",
                      data: trCatalog.value.where((value) {
                        var code = value["code"];
                        for (var i = 0; i < travelRhytmAges.keys.length; i++) {
                          var range = [
                            travelRhytmAges.keys.toList()[i],
                            travelRhytmAges.keys.toList()[
                                i >= travelRhytmAges.keys.length - 1
                                    ? i
                                    : i + 1]
                          ];

                          if (customerAge.value < 20) {
                            return true;
                          }
                          if (customerAge.value >= range[0] &&
                              customerAge.value <= range[1]) {
                            if (travelRhytmAges[range[0]]!
                                .contains(code.toString())) {
                              return true;
                            }
                          }
                        }
                        return false;
                      }).toList() as List<Map<String, dynamic>>);
                }),
                Obx(() {
                  return CustomFormMultiDropDownFieldWidget(
                    validator: (value) => CustomMultiDropdownRequiredValidator(
                        value,
                        errorText: "Key Activities are required ",
                        context: context),
                    value: keyActivities,
                    onSaved: (value) {
                      setFormValue(globalctx.memory["destinations"], destination,
                          "keyActivities", ["CULTURE"]);
                      setFormValue(
                          globalctx.memory["destinations"],
                          destination,
                          "keyActivities",
                          value!.map((e) => e["description"]).toSet().toList());
                    },
                    onChanged: (value) {
                      setFormValue(globalctx.memory["destinations"], destination,
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
