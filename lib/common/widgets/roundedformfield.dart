import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/constants.dart';

class RoundedFormField extends StatelessWidget {
  final double horizontal;
  final double vertical;
  final double width;
  final double height;
  final double fontWeight;
  final String hintText;

  RoundedFormField(
      {Key? key,
      required this.hintText,
      this.horizontal = 30,
      this.vertical = 30,
      this.width = 1,
      this.height = 0.1,
      this.fontWeight = 0.020,
      required this.onSaved,
      this.password = false})
      : super(key: key);

  final void Function(String?)? onSaved;
  bool password;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * width,
      height: MediaQuery.of(context).size.height * height,
      padding: EdgeInsets.symmetric(
        horizontal: horizontal,
        vertical: vertical,
      ),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(50)),
      child: TextFormField(
        cursorColor: Colors.grey,
        style: TextStyle(
          color: Colors.grey,
          fontSize: MediaQuery.of(context).size.width /
              MediaQuery.of(context).size.height *
              16,
        ),
        decoration: InputDecoration.collapsed(
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: MediaQuery.of(context).size.width /
                MediaQuery.of(context).size.height *
                16,
            decorationStyle: TextDecorationStyle.solid,
          ),
          hintText: hintText,
        ),
        onSaved: onSaved,
        obscureText: password,
      ),
    );
  }
}
