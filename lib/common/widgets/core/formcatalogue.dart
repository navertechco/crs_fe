import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../index.dart';

// ignore: must_be_immutable
class FormCatalogueWidget extends StatelessWidget {
  FormCatalogueWidget(
      {Key? key,
      this.disabled = false,
      required this.value,
      required this.data,
      this.hintText = "Choose a Option",
      required this.onChanged,
      required this.onSaved,
      this.validator})
      : super(key: key);

  List<Map<String, dynamic>> data;
  final String? hintText;
  void Function(String?) onSaved;
  void Function(String?) onChanged;
  final String? value;
  final bool disabled;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    Rx<List<DropdownMenuItem<String>>>? items = Rx([]);
    List<Map<String, dynamic>> data2 = [];
    data2.add({"code": "0", "description": "Choose a Option"});
    data2.addAll(data);
    data2.asMap().forEach((index, item) {
      items.value.add(DropdownMenuItem(
        value: item["code"].toString(),
        child: Text(item["description"]),
      ));
    });
    return Obx(() {
      return DropdownButtonHideUnderline(
        child: DropdownButtonFormField(
          style: KTextSytle(context, 10, FontWeight.normal),
          alignment: Alignment.centerLeft,
          isExpanded: true,
          value: value,
          disabledHint: Text(
            "data",
            style: KTextSytle(context, 20, FontWeight.normal),
          ),
          validator: validator,
          decoration: InputDecoration.collapsed(
            filled: false,
            hintText: hintText,
            hintStyle: KTextSytle(context, 10, FontWeight.normal),
          ),
          onSaved: onSaved,
          onChanged: disabled ? null : onChanged,
          items: items.value,
        ),
      );
    });
  }
}

class T {}
