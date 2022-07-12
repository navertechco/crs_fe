import 'package:flutter/material.dart';

import '../../../../../index.dart';

class KAWidget extends StatelessWidget {
  const KAWidget({
    Key? key,
    required this.keyActivities,
    required this.index,
  }) : super(key: key);

  final List<String> keyActivities;
  final index;

  @override
  Widget build(BuildContext context) {
    return CustomFormMultiDropDownFieldWidget(
      validator: (value) => CustomMultiDropdownRequiredValidator(value,
          errorText: "Key Activities are required ", context: context),
      value: keyActivities,
      onSaved: (values) {
        if (values == null) return;

        if (values.length <= 3) {
          kaMemory.value = [];
          var length = values.length;

          for (var i = 0; i < length; i++) {
            kaMemory.add(findCatalog("key_activity")
                .toList()
                .where((e) => e["code"] == values[i])
                .toList()[0]["description"]);
          }
          setFormValue(globalctx.memory["destinations"], index,
              "key_activities", kaMemory.value);
        }
      },
      onChanged: (value) {
        setFormValue(
            globalctx.memory["destinations"], index, "key_activities", value);
      },
      hintText: " ",
      label: "Key Activities            ",
      data: findCatalog("key_activity"),
    );
  }
}

