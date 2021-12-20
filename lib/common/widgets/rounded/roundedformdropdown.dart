// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import '../index.dart';

class RoundedFormDropdown extends StatelessWidget {
  final double left;
  final double top;
  final double width;
  final double height;
  final double fontSize;
  final String? hintText;
  final String? label;
  final String value;
  List<Map<String, dynamic>> data;
  void Function(String?) onSaved;
  void Function(String?) onChanged;

  RoundedFormDropdown(
      {Key? key,
      required this.data,
      this.hintText,
      this.label,
      this.left = 15,
      this.top = 8,
      this.width = 0.2,
      this.height = 0.05,
      this.fontSize = 0.1,
      required this.onSaved,
      this.password = false,
      this.value = "9999",
      required this.onChanged})
      : super(key: key);

  bool password;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * width,
      height: MediaQuery.of(context).size.height * height,
      padding: EdgeInsets.only(left: left, top: top),
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(50)),
      child: FormCatalogueWidget(
          value: value,
          onChanged: onChanged,
          onSaved: onSaved,
          data: data,
          hintText: hintText),
    );
  }
}
