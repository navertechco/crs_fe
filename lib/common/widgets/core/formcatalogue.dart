import 'package:flutter/material.dart';
import 'package:get/get.dart';  
import '../../index.dart';

// ignore: must_be_immutable
class FormCatalogueWidget extends StatelessWidget {
  FormCatalogueWidget(
      {Key? key,
      required this.value,
      required this.data,
      this.hintText = "Choose a Option",
      required this.onChanged,
      required this.onSaved})
      : super(key: key);

  List<Map<String, dynamic>> data;
  final String? hintText;
  void Function(String?) onSaved;
  void Function(String?) onChanged;
  final String? value;
  @override
  Widget build(BuildContext context) {
    Rx<List<DropdownMenuItem<String>>>? items = Rx([]);
    List<Map<String, dynamic>> data2 = [];
    data2.add({"code": "9999", "description": hintText});
    data2.addAll(data);
    data2.asMap().forEach((index, item) {
      items.value.add(DropdownMenuItem(
        value: item["code"],
        child: Text(item["description"]),
      ));
    });
    return Obx(() {
      return DropdownButtonHideUnderline(
        child: DropdownButtonFormField(
          style: KTextSytle(context, 10),
          alignment: Alignment.centerLeft,
          isExpanded: true,
          value: value,
          // validator: (value) => value == null ? 'required' : null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration.collapsed(
            filled: false,
            hintText: hintText,
            hintStyle: KTextSytle(context, 10),
          ),
          onSaved: onSaved,
          onChanged: onChanged,
          items: items.value,
        ),
      );
    });
  }
}

class T {}
