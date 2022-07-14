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
        saveMultiDropDown([globalctx.memory["destinations"], index,
              "key_activities",],findCatalog("key_activity"),values, 3);
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

