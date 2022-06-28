// ignore_for_file: unused_local_variable, prefer_function_declarations_over_variables, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';

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
      this.validator,
      this.fontSize = 10})
      : super(key: key);
  final fontSize;
  List<Map<String, dynamic>> data;
  final String? hintText;
  void Function(String?) onSaved;
  void Function(String?) onChanged;
  final String value;
  final bool disabled;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    var items = getItems(data, value, hintText);

    return Obx(() {
      try {
        return DropdownButtonHideUnderline(
          child: DropdownButtonFormField(
            style: KTextSytle(
                    context: context,
                    fontSize: isMobile * fontSize,
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
                      fontSize: isMobile * fontSize,
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
                      fontSize: isMobile * fontSize,
                      fontWeight:
                          value == null ? FontWeight.normal : FontWeight.bold)
                  .getStyle(),
            ),
            onSaved: onSaved,
            onChanged: disabled ? null : onChanged,
            items: items,
          ),
        );
      } catch (e) {
        log(e);
        return Text('');
      }
    });
  }
}

class T {}
