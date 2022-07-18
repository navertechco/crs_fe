import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../index.dart';

class TRWidget extends StatelessWidget {
  const TRWidget({
    Key? key,
    required this.type,
    required this.explorationMode,
    required this.destination,
    required this.index,
  }) : super(key: key);

  final type;
  final RxString explorationMode;
  final String destination;
  final index;

  @override
  Widget build(BuildContext context) {
    return CustomFormDropDownFieldWidget(
        disabled: type == "arrival" ||
            type == "departure" ||
            explorationMode.value != "0" ||
            destination.contains("galapagos"),
        validator: CustomRequiredValidator(
            errorText: "Travel Rhythm is required ", ctx: context),
        value: getFormValue(globalctx.memory["destinations"], index,
            "travel_rhythm", destination.contains("galapagos") ? "3" : "1"),
        onSaved: (value) {
          setFormValue(globalctx.memory["destinations"], index, "travel_rhythm",
              destination.contains("galapagos") ? "3" : value);
        },
        onChanged: (value) {
          setFormValue(globalctx.memory["destinations"], index, "travel_rhythm",
              destination.contains("galapagos") ? "3" : value);
        },
        label: "Travel Rhythm         ",
        data: findCatalog("travel_rhythm"));
  }
}
