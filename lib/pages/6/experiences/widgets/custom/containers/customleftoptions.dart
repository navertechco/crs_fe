
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../index.dart';

class CustomLeftOptionsWidget extends StatelessWidget {
  const CustomLeftOptionsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Rx<Map<dynamic, dynamic>> localdata =
        Rx(globalctx.context.value["experiencedata"]);
    Rx<dynamic> travelOptions =
        Rx(getValue(localdata.value, "destination_option"));
    Rx<dynamic> keyActivities = Rx(getValue(localdata.value, "key_activity"));
    Rx<dynamic> travelRhythm = Rx(getValue(localdata.value, "travel_rhythm"));
    Rx<dynamic> transportService =
        Rx(getValue(localdata.value, "service_type"));
    Rx<dynamic> translateService =
        Rx(getValue(localdata.value, "translate_service"));

    Rx<int> val = Rx(0);
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
                    Obx(() {
                      return CustomFormMultiDropDownFieldWidget(
                        // label: "Exploration Days",
                        value: transportService.value,
                        onSaved: (value) {
                          transportService.value = value;
                        },
                        onChanged: (value) {
                          transportService.value = value;
                        },
                        hintText: "                  Services",
                        data: processCatalog("service_type"),
                      );
                    }),
                    Obx(() {
                      var index;
                      if (translateService.value != null) {
                        index = translateService.value
                            .indexWhere((element) => element["code"] == 2);
                        if (index != -1) {
                          return CustomFormMultiDropDownFieldWidget(
                            // label: "Exploration Days",
                            value: [],
                            onSaved: (value) {},
                            onChanged: (value) {},
                            hintText: "                  Translator",
                            data: processCatalog("translate_service"),
                          );
                        }
                      }
                      return Text("");
                    }),
                    Obx(() {
                      var index;
                      if (translateService.value != null) {
                        index = translateService.value
                            .indexWhere((element) => element["code"] == 1);
                        if (index != -1) {
                          return Column(
                            children: [
                              CustomFormCheckboxWidget(
                                value: 1,
                                groupValue: val,
                                onChanged: (value) {
                                  if (val.value == value) {
                                    val.value = 0;
                                  } else {
                                    val.value = value;
                                  }
                                },
                                hintText: "Driver guide?",
                              ),
                              CustomFormCheckboxWidget(
                                value: 2,
                                groupValue: val,
                                onChanged: (value) {
                                  if (val.value == value) {
                                    val.value = 0;
                                  } else {
                                    val.value = value;
                                  }
                                },
                                hintText: "Additional guide?",
                              ),
                            ],
                          );
                        }
                      }
                      return Text("");
                    }),
                    CustomTitleWidget(
                      fontWeight: FontWeight.bold,
                      label: "Filter Experiences by:",
                    ),
                    CustomTitleWidget(
                      fontWeight: FontWeight.bold,
                      label: "______________________",
                    ),
                    CustomFormDropDownFieldWidget(
                      // label: "Exploration Days",
                      value: travelOptions.value,
                      onSaved: (value) {},
                      onChanged: (value) {},
                      hintText: "Travel Options",
                      data: processCatalog("destination_option"),
                    ),
                    CustomFormMultiDropDownFieldWidget(
                      value: keyActivities.value,
                      onSaved: (value) {},
                      onChanged: (value) {
                        // setData(localdata[experience],"key_activities", value);
                      },
                      hintText: "Key Activities            ",
                      data: processCatalog("key_activity"),
                    ),
                    CustomFormDropDownFieldWidget(
                      // label: "Exploration Days",
                      value: travelRhythm.value,
                      onSaved: (value) {},
                      onChanged: (value) {},
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
