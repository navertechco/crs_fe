import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../index.dart';

class ExpModeWidget extends StatelessWidget {
  const ExpModeWidget({
    Key? key,
    required this.explorationMode,
    required this.index,
    required this.destination,
  }) : super(key: key);

  final RxString explorationMode;
  final index;
  final String destination;

  @override
  Widget build(BuildContext context) {
    return CustomFormDropDownFieldWidget(
      validator: CustomRequiredValidator(
          errorText: "Exploration mode is required ", ctx: context),
      value: explorationMode.value,
      onSaved: (value) {
        setFormValue(
            globalctx.memory["destinations"], index, "explorationMode", value);
      },
      onChanged: (value) {
        setFormValue(
            globalctx.memory["destinations"], index, "explorationMode", value);
        explorationMode.value = value!;
      },
      label: "Exploration Mode    ",
      data: findCatalog("exploration_mode")
          .where((element) =>
              element["relation"]["destination"] == null ||
              element["relation"]["destination"] == destination)
          .toList(),
    );
  }
}

