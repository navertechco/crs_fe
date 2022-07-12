
import 'package:flutter/material.dart';

import '../../../../../index.dart';

class ExpDaysCounterWidget extends StatelessWidget {
  const ExpDaysCounterWidget({
    Key? key,
    required this.index,
    required this.type,
  }) : super(key: key);

  final index;
  final type;

  @override
  Widget build(BuildContext context) {
    return CustomFormCounterFieldWidget(
        initial: int.parse(getFormValue(
            globalctx.memory["destinations"], index, "explorationDay", "0")),
        min: 0,
        max: dayleft.value + (type == "departure" ? 1 : 0),
        bound: 0,
        onValueChanged: (value) {
          saveExplorationDay(
              index,
              int.parse(getFormValue(globalctx.memory["destinations"], index,
                  "explorationDay", "0")),
              value as int);
        },
        label: "  Exploration Days     ",
        width: 0.20);
  }
}
