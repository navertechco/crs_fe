import 'package:flutter/material.dart';

import '../index.dart';


class CustomFormDropDownFieldWidget extends StatelessWidget {
  const CustomFormDropDownFieldWidget({
    Key? key,
    required this.label,
    required this.data,
  }) : super(key: key);

  final String label;
  final List<Map<String, dynamic>> data;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CustomFormLabelWidget(label: label, fontWeight: FontWeight.normal),
          SizedBox(width: MediaQuery.of(context).size.width * 0.01),
          RoundedFormDropdown(
            data: data,
            hintText: "",
            onSaved: (value) {},
          )
        ],
      ),
    );
  }
}
