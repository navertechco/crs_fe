// ignore_for_file: must_be_immutable, unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';
import '../../index.dart';

class RoundedFormMultiDropdown extends StatelessWidget {
  final double left;
  final double top;
  final double width;
  final double height;
  final double fontSize;
  final String? hintText;
  final String? label;
  final void Function(List<Map<String, dynamic>>?) onSaved;
  final void Function(List<String>?) onChanged;
  final List<Map<String, dynamic>> data;
  final List<String> value;
  final String? Function(List<Map<String, dynamic>>?)? validator;

  RoundedFormMultiDropdown(
      {Key? key,
      required this.data,
      this.hintText,
      this.label,
      this.left = 0,
      this.top = 8,
      this.width = 0.2,
      this.height = 0.025,
      this.fontSize = 10,
      required this.onSaved,
      this.password = false,
      this.value = const [],
      required this.onChanged,
      this.validator})
      : super(key: key);

  bool password;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * width,
      padding: EdgeInsets.only(left: left, top: top),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.05,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(50)),
        child: DropDownMultiSelect(
            onChanged: onChanged,
            options: data.map((e) => e["description"].toString()).toList(),
            selectedValues: value,
            whenEmpty: value == null ? hintText : '',
            childBuilder: (value) {
              return Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.015,
                  left: MediaQuery.of(context).size.width * 0.03,
                ),
                child: Text(
                    value == null
                        ? hintText!
                        : value
                            .toString()
                            .replaceAll("[", "")
                            .replaceAll("]", ""),
                    style: KTextSytle(
                            context: context,
                            fontSize: (value == null ? 10 : 8),
                            fontWeight: (value == null
                                ? FontWeight.normal
                                : FontWeight.bold))
                        .getStyle()),
              );
            },
            decoration: InputDecoration.collapsed(
                fillColor: Colors.grey, hintText: "")),
      ),
    );
  }
}
