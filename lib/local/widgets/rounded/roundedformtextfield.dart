// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';
import 'package:flutter/services.dart';

class RoundedFormTextField extends StatelessWidget {
  final bool disabled;
  final double left;
  final double top;
  final double width;
  final double height;
  final fontSize;
  final String hintText;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  final void Function(String?)? onFieldSubmitted;
  final TextInputType? keyboardType;
  String? Function(String?)? validator;
  String? initialValue;
  List<TextInputFormatter>? inputFormatters;
  RoundedFormTextField(
      {Key? key,
      required this.hintText,
      this.left = 35,
      this.top = 2,
      this.width = 0.2,
      this.height = 0.05,
      this.fontSize = 0.1,
      this.validator,
      this.onChanged,
      this.onFieldSubmitted,
      this.onSaved,
      this.initialValue,
      this.keyboardType = TextInputType.text,
      this.inputFormatters = const [],
      this.password = false,
      this.disabled = false})
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
      foregroundDecoration: BoxDecoration(
          color: Color.fromARGB(0, 0, 0, 0),
          borderRadius: BorderRadius.circular(50)),
      child: TextFormField(
        // autofocus: true,
        readOnly: disabled,
        initialValue: initialValue,
        inputFormatters: inputFormatters,
        validator: validator,
        keyboardType: keyboardType,
        onSaved: onSaved,
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChanged,
        obscureText: password,
        cursorColor: Colors.black54,
        style: KTextSytle(
                context: context,
                fontSize: isMobile * fontSize,
                fontWeight:
                    initialValue == null ? FontWeight.normal : FontWeight.bold)
            .getStyle(),
        decoration: InputDecoration.collapsed(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.black54,
            fontSize: MediaQuery.of(context).size.width /
                MediaQuery.of(context).size.height *
                isMobile *
                10,
            decorationStyle: TextDecorationStyle.solid,
          ),
        ),
      ),
    );
  }
}
