// ignore_for_file: unused_local_variable, prefer_function_declarations_over_variables, unnecessary_null_comparison

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
  final String value;
  final bool disabled;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    var items = getItems(data, value);
    // var realValue = (() {
    //   if (value != null) {
    //     return (int.parse(value) > items.length - 1)
    //         ? (items.length - 1).toString()
    //         : value;
    //   }
    //   return "0";
    // })();
    return Obx(() {
      return DropdownButtonHideUnderline(
        child: DropdownButtonFormField(
          style: KTextSytle(
                  context: context,
                  fontSize: value == null ? 10 : 8,
                  fontWeight:
                      value == null ? FontWeight.normal : FontWeight.bold)
              .getStyle(),
          alignment: Alignment.centerLeft,
          isExpanded: true,
          value: value,
          disabledHint: Text(
            "data",
            style: KTextSytle(
                    context: context,
                    fontSize: value == null ? 10 : 8,
                    fontWeight:
                        value == null ? FontWeight.normal : FontWeight.bold)
                .getStyle(),
          ),
          validator: validator,
          decoration: InputDecoration.collapsed(
            filled: false,
            hintText: hintText,
            hintStyle: KTextSytle(
                    context: context,
                    fontSize: value == null ? 10 : 8,
                    fontWeight:
                        value == null ? FontWeight.normal : FontWeight.bold)
                .getStyle(),
          ),
          onSaved: onSaved,
          onChanged: disabled ? null : onChanged,
          items: items,
        ),
      );
    });
  }
}

class T {}
