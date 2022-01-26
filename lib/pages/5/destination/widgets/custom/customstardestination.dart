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
                    value: ctrl.state.explorationDay.value,
                    onSaved: (value) {
                      ctrl.state.explorationDay.value = value!;
                    },
                    onChanged: (value) {
                      ctrl.state.explorationDay.value = value!;
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
                          value: ctrl.state.explorationMode.value,
                          onSaved: (value) {
                            ctrl.state.explorationMode.value = value!;
                          },
                          onChanged: (value) {
                            ctrl.state.explorationMode.value = value!;
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
                    value: ctrl.state.destinationOption.value,
                    onSaved: (value) {
                      ctrl.state.destinationOption.value = value!;
                    },
                    onChanged: (value) {
                      ctrl.state.destinationOption.value = value!;
                    },
                    label: "Destination Option",
                    data: processCatalog("destination_option"),
                  );
                }),
                Obx(() {
                  return CustomFormDropDownFieldWidget(
                    validator: CustomRequiredValidator(
                        errorText: "Travel Rhythm is required ", ctx: context),
                    value: ctrl.state.travelRhythm.value,
                    onSaved: (value) {
                      ctrl.state.travelRhythm.value = value!;
                    },
                    onChanged: (value) {
                      ctrl.state.travelRhythm.value = value!;
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
                    value: ctrl.state.keyActivities.value,
                    onSaved: (value) {
                      print(value);
                      ctrl.state.keyActivities.value = value!;
                    },
                    onChanged: (value) {
                      ctrl.state.keyActivities.value = value!;
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
