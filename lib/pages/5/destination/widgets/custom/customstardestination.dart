// ignore_for_file: prefer_function_declarations_over_variables, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                    value: getFormValue(ctrl.state.memory, destination,
                        "explorationDay", "9999"),
                    onSaved: (value) {
                      setFormValue(ctrl.state.memory, destination,
                          "explorationDay", value);
                    },
                    onChanged: (value) {
                      setFormValue(ctrl.state.memory, destination,
                          "explorationDay", value);
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
                              "explorationMode", "9999"),
                          onSaved: (value) {
                            setFormValue(ctrl.state.memory, destination,
                                "explorationMode", value);
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
                        "destinationOption", "9999"),
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
                        ctrl.state.memory, destination, "travelRhythm", "9999"),
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
                        "keyActivities", Map<String, dynamic>()[{}]),
                    onSaved: (value) {
                      setFormValue(ctrl.state.memory, destination,
                          "keyActivities", value);
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
