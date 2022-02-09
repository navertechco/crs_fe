


import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

import '../../../../../index.dart';
import '../../../controller.dart';

class TransportFilter extends HookWidget {
  const TransportFilter({
    Key? key,
    required this.ctrl,
  }) : super(key: key);

  final ExperiencesController ctrl;

  @override
  Widget build(BuildContext context) {
    Rx<dynamic> transportService = Rx(getFormValue(
            ctrl.state.memory["destinations"],
            destination.value,
            "service_type", <String>[]) ??
        <String>[]);
    Rx<dynamic> translatingService = Rx(getFormValue(
        ctrl.state.memory["destinations"],
        destination.value,
        "translating_service", <String>[]));
    Rx<int> guide = Rx(getFormValue(
        ctrl.state.memory["destinations"], destination.value, "guide_type", 1));

    Rx<int> guideIndex = Rx(
        transportService.value.indexWhere((element) => element == "GUIDING") ??
            0);
    Rx<int> translateIndex = Rx(transportService.value
            .indexWhere((element) => element == "TRANSLATING") ??
        0);
    var serviceTypeCatalog = Rx(processCatalog("service_type"));
    var translatingCatalog = Rx(processCatalog("translating_service"));
    return Obx(() {
      return Column(
        children: [
          CustomTitleWidget(
            fontWeight: FontWeight.bold,
            label: "Day Transport Options:",
          ),
          CustomTitleWidget(
            fontWeight: FontWeight.bold,
            label: "______________________",
          ),
          CustomFormMultiDropDownFieldWidget(
            // label: "Exploration Days",
            value: getFormValue(ctrl.state.memory["destinations"],
                destination.value, "service_type", <String>[]),
            onSaved: (value) {
              transportService.value = value;
              guideIndex.value = transportService.value
                  .indexWhere((element) => element == "GUIDING");
              translateIndex.value = transportService.value
                  .indexWhere((element) => element == "TRANSLATING");
              setFormValue(ctrl.state.memory["destinations"], destination.value,
                  "service_type", value);
            },
            onChanged: (value) {
              transportService.value = value;
              guideIndex.value = transportService.value
                  .indexWhere((element) => element == "GUIDING");
              translateIndex.value = transportService.value
                  .indexWhere((element) => element == "TRANSLATING");
              setFormValue(ctrl.state.memory["destinations"], destination.value,
                  "service_type", value);
            },
            hintText: "                  Services\n",
            data: serviceTypeCatalog.value,
          ),
          if (translateIndex.value != -1)
            CustomFormMultiDropDownFieldWidget(
              // label: "Exploration Days",
              value: translatingService.value,
              onSaved: (value) {
                setFormValue(ctrl.state.memory["destinations"],
                    destination.value, "translating_service", value);
              },
              onChanged: (value) {
                translateIndex.value = value!.isNotEmpty ? 0 : -1;
                translatingService.value = value;
                setFormValue(ctrl.state.memory["destinations"],
                    destination.value, "translating_service", value);
              },
              hintText: "          Translating Services",
              data: translatingCatalog.value,
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
                      setFormValue(ctrl.state.memory["destinations"],
                          destination.value, "guide_type", value);
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
                      setFormValue(ctrl.state.memory["destinations"],
                          destination.value, "guide_type", value);
                    }
                  },
                  hintText: "Additional guide?",
                ),
              ],
            )
        ],
      );
    });
  }
}