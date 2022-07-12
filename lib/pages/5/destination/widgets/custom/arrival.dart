import 'package:flutter/material.dart';

import '../../../../../index.dart';

class ArrivalWidget extends StatelessWidget {
  const ArrivalWidget({
    Key? key,
    required this.index,
    required this.arrivalHourCatalog,
  }) : super(key: key);

  final index;
  final List<Map<String, dynamic>> arrivalHourCatalog;

  @override
  Widget build(BuildContext context) {
    return CustomFormDropDownFieldWidget(
        validator: CustomRequiredValidator(
            errorText: "Arrival Hour is required ", ctx: context),
        value: getFormValue(
            globalctx.memory["destinations"], index, "arrival_hour", "0"),
        onSaved: (value) {
          setFormValue(
              globalctx.memory["destinations"], index, "arrival_hour", value);
          arrivalHour.value =
              filterCatalog("arrival_hour", "code", int.parse(value!))[0]
                  ["description"];
        },
        onChanged: (value) {
          setFormValue(
              globalctx.memory["destinations"], index, "arrival_hour", value);
          arrivalHour.value =
              filterCatalog("arrival_hour", "code", int.parse(value!))[0]
                  ["description"];
        },
        label: "Arrival Hour              ",
        data: arrivalHourCatalog);
  }
}
