import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class FormCatalogueWidget extends StatelessWidget {
  FormCatalogueWidget(
      {Key? key,
      required this.data,
      this.hintText = "Choose a Option",
      this.onChanged,
      this.onSaved})
      : super(key: key);

  List<Map<String, dynamic>> data;
  final String? hintText;
  final onSaved;
  final onChanged;
  @override
  Widget build(BuildContext context) {
    Rx<List<DropdownMenuItem<String>>>? items = Rx([]);
    data.asMap().forEach((index, item) {
      items.value.add(DropdownMenuItem(
        value: item["code"],
        child: Text(item["description"]),
      ));
    });
    return Obx(() {
      return DropdownButtonHideUnderline(
        child: DropdownButtonFormField(
          alignment: Alignment.centerLeft,
          isExpanded: true,
          validator: (value) => value == null ? 'required' : null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration.collapsed(hintText: hintText),
          onSaved: onSaved,
          onChanged: onChanged,
          items: items.value,
        ),
      );
    });
  }
}

class T {}
