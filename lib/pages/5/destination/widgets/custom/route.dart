import 'package:flutter/material.dart';

import '../../../../../index.dart';

class RouteWidget extends StatelessWidget {
  const RouteWidget({
    Key? key,
    required this.index,
  }) : super(key: key);
  final index;
  @override
  Widget build(BuildContext context) {
    return CustomFormMultiDropDownFieldWidget(
        validator: (value) => CustomMultiDropdownRequiredValidator(value,
            errorText: "Key Activities are required ", context: context),
        value: <String>[],
        onSaved: (values) {
          if (values == null) return;
          saveMultiDropDown([
            globalctx.memory["destinations"],
            index,
            "key_activities",
          ], findCatalog("key_activity"), values, 3);
        },
        onChanged: (value) {
          setFormValue(
              globalctx.memory["destinations"], index, "key_activities", value);
        },
        hintText: " ",
        label: "Routes Information",
        data: findCatalog("islets"));
  }
}
