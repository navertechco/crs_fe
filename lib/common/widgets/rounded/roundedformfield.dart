// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:naver_crs/common/constants.dart';

class RoundedFormField extends StatelessWidget {
  final bool disabled;
  final double left;
  final double top;
  final double width;
  final double height;
  final double fontSize;
  final String hintText;
  final void Function(String?)? onSaved;
  final TextInputType? keyboardType;
  String? Function(String?)? validator;
  final String? initialValue;
  RoundedFormField(
      {Key? key,
      required this.hintText,
      this.left = 45,
      this.top = 10,
      this.width = 0.2,
      this.height = 0.05,
      this.fontSize = 0.1,
      this.validator,
      required this.onSaved,
      this.initialValue,
      this.keyboardType = TextInputType.text,
      this.password = false,
      this.disabled = false})
      : super(key: key);

  bool password;
  @override
  Widget build(BuildContext context) {
    var isMobile = isMobileDevice() ? 1.2 : 1;
    return Container(
      width: MediaQuery.of(context).size.width * width,
      height: MediaQuery.of(context).size.height * height,
      padding: EdgeInsets.only(left: left, top: top),
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(50)),
      child: TextFormField(
        readOnly: disabled,
        initialValue: initialValue,
        validator: validator,
        keyboardType: keyboardType,
        onSaved: onSaved,
        obscureText: password,
        cursorColor: Colors.black54,
        style: TextStyle(
          color: Colors.black54,
          fontSize: MediaQuery.of(context).size.width /
              MediaQuery.of(context).size.height *
              isMobile *
              10,
          decorationStyle: TextDecorationStyle.solid,
        ),
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
