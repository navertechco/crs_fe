import 'package:flutter/material.dart';

import '../index.dart';

// ignore: must_be_immutable
class FormCatalogueWidget extends StatelessWidget {
  FormCatalogueWidget({Key? key, required this.data, required this.label})
      : super(key: key);

  final List<Map<String, dynamic>> data;
  final String label;

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>>? items = [];
    data.asMap().forEach((index, item) {
      items.add(DropdownMenuItem(
        value: item["code"],
        child: Text(item["description"]),
      ));
    });
    return DropdownButtonFormField(
      validator: (value) => value == null ? 'required' : null,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: "Choose a Option",
        label: TextFieldName(text: label),
      ),
      onSaved: (value) {},
      onChanged: (value) {},
      items: items,
    );
  }
}

class T {}
