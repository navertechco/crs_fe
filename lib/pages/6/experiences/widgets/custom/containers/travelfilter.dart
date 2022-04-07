import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/index.dart';

import '../../../../../index.dart';

class TravelFilter extends HookWidget {
  const TravelFilter({
    Key? key,
    required this.ctrl,
    required this.counter,
  }) : super(key: key);
  final ValueNotifier<int> counter;
  final ExperiencesController ctrl;

  @override
  Widget build(BuildContext context) {
    var index = 0;

    Rx<dynamic> keyActivities = Rx(getFormValue(
        globalctx.memory["destinations"], index, "keyActivities", <String>[]));

    Rx<dynamic> destinationOption = Rx(getFormValue(
        globalctx.memory["destinations"], index, "destinationOption", "0"));

    Rx<dynamic> travelRhythm = Rx(getFormValue(
        globalctx.memory["destinations"], index, "travel_rhythm", "0"));

    

    var kaDataCatalog = Rx(processCatalog("key_activity"));
    return Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.25,
            child: Column(
              children: [
                CustomTitleWidget(
                  fontWeight: FontWeight.bold,
                  label: "Filter Experiences by:",
                ),
                const Divider(
                  color: Colors.black,
                  height: 25,
                  thickness: 2,
                  indent: 5,
                  endIndent: 5,
                ),
                Obx(() {
                  return Column(
                    children: [
                      CustomFormDropDownFieldWidget(
                        value: destinationOption.value,
                        onSaved: (value) {
                          setFormValue(globalctx.memory["destinations"], index,
                              "destinationOption", value);
                        },
                        onChanged: (value) {
                          setFormValue(globalctx.memory["destinations"], index,
                              "destinationOption", value);
                        },
                        hintText: "Travel Options",
                        data: processCatalog("destination_option"),
                      ),
                      CustomFormDropDownFieldWidget(
                        value: travelRhythm.value,
                        onSaved: (value) {
                          setFormValue(globalctx.memory["destinations"], index,
                              "travel_rhythm", value);
                        },
                        onChanged: (value) {
                          setFormValue(globalctx.memory["destinations"], index,
                              "travel_rhythm", value);
                        },
                        hintText: "Travel Rhythm",
                        data: processCatalog("travel_rhythm"),
                      ),
                      CustomFormMultiDropDownFieldWidget(
                        validator: (value) =>
                            CustomMultiDropdownRequiredValidator(value,
                                errorText: "Key Activities are required ",
                                context: context),
                        value: keyActivities.value,
                        onSaved: (value) {
                          setFormValue(globalctx.memory["destinations"], index,
                              "keyActivities", null);
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
                        hintText:
                            "\t\t\t\t\t\t\t\t\t\t\t\tKey Activities            \n",
                        data: kaDataCatalog.value,
                      )
                    ],
                  );
                }),
              ],
            )));
  }
}
