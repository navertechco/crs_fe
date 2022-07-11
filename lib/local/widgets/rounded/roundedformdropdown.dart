// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';

class RoundedFormDropdown extends StatelessWidget {
  final double left;
  final double top;
  final double width;
  final double height;
  final fontSize;
  final String? hintText;
  final String? label;
  final String value;
  List<Map<String, dynamic>> data;
  void Function(String?) onSaved;
  void Function(String?) onChanged;
  final bool disabled;
  final String? Function(String?)? validator;

  RoundedFormDropdown(
      {Key? key,
      required this.data,
      this.hintText,
      this.label,
      this.left = 15,
      this.top = 4,
      this.width = 0.2,
      this.height = 0.05,
      this.fontSize = 10,
      required this.onSaved,
      this.password = false,
      this.value = "0",
      this.disabled = false,
      required this.onChanged,
      this.validator})
      : super(key: key);

  bool password;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * isMobile * width,
      height: MediaQuery.of(context).size.height * isMobile * height,
      padding: EdgeInsets.only(left: isMobile * left, top: isMobile * top),
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(50)),
      child: FormCatalogueWidget(
        fontSize:fontSize,
          validator: validator,
          disabled: disabled,
          value: value,
          onChanged: onChanged,
          onSaved: onSaved,
          data: data,
          hintText: hintText),
    );
  }
}
