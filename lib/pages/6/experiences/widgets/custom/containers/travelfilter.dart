import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/validators.dart';

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
    Rx<dynamic> keyActivities = Rx(getFormValue(
        ctrl.state.memory["destinations"],
        globalDestination.value,
        "keyActivities", <String>[]));

    Rx<dynamic> destinationOption = Rx(getFormValue(
        ctrl.state.memory["destinations"],
        globalDestination.value,
        "destinationOption",
        "0"));

    Rx<dynamic> travelRhythm = Rx(getFormValue(
        ctrl.state.memory["destinations"],
        globalDestination.value,
        "travel_rhythm",
        "0"));

    useEffect(() {
      print("INNER LEFT RENDER");
      destinationOption.value = "0";
      travelRhythm.value = "0";
      keyActivities.value = <String>[];
    }, [stream, counter.value]);

    var kaDataCatalog = Rx(processCatalog("key_activity"));
    return Column(
      children: [
        CustomTitleWidget(
          fontWeight: FontWeight.bold,
          label: "Filter Experiences by:",
        ),
        CustomTitleWidget(
          fontWeight: FontWeight.bold,
          label: "______________________",
        ),
        Obx(() {
          return Column(
            children: [
              CustomFormDropDownFieldWidget(
                value: destinationOption.value,
                onSaved: (value) {
                  setFormValue(ctrl.state.memory["destinations"],
                      globalDestination.value, "destinationOption", value);
                },
                onChanged: (value) {
                  setFormValue(ctrl.state.memory["destinations"],
                      globalDestination.value, "destinationOption", value);
                },
                hintText: "Travel Options",
                data: processCatalog("destination_option"),
              ),
              CustomFormDropDownFieldWidget(
                value: travelRhythm.value,
                onSaved: (value) {
                  setFormValue(ctrl.state.memory["destinations"],
                      globalDestination.value, "travel_rhythm", value);
                },
                onChanged: (value) {
                  setFormValue(ctrl.state.memory["destinations"],
                      globalDestination.value, "travel_rhythm", value);
                },
                hintText: "Travel Rhythm",
                data: processCatalog("travel_rhythm"),
              ),
              CustomFormMultiDropDownFieldWidget(
                validator: (value) => CustomMultiDropdownRequiredValidator(
                    value,
                    errorText: "Key Activities are required ",
                    context: context),
                value: keyActivities.value,
                onSaved: (value) {
                  setFormValue(ctrl.state.memory["destinations"],
                      globalDestination.value, "keyActivities", null);
                  setFormValue(
                      ctrl.state.memory["destinations"],
                      globalDestination.value,
                      "keyActivities",
                      value!.map((e) => e["description"]).toSet().toList());
                },
                onChanged: (value) {
                  setFormValue(globalctx.memory["destinations"],
                      globalDestination.value, "keyActivities", value);
                },
                hintText:
                    "\t\t\t\t\t\t\t\t\t\t\t\tKey Activities            \n",
                data: kaDataCatalog.value,
              )
            ],
          );
        }),
      ],
    );
  }
}
