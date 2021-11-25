import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/constants.dart';

class RoundedFormField extends StatelessWidget {
  final double horizontal;
  final double vertical;
  final double width;
  final double height;
  final double fontSize;
  final String hintText;
  final void Function(String?)? onSaved;

  RoundedFormField(
      {Key? key,
      required this.hintText,
      this.horizontal = 20,
      this.vertical = 20,
      this.width = 0.3,
      this.height = 0.2,
      this.fontSize = 0.1,
      required this.onSaved,
      this.password = false})
      : super(key: key);

  bool password;
  @override
  Widget build(BuildContext context) {
    var isMobile = isMobileDevice() ? 1.2 : 1;
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
        onSaved: onSaved,
        obscureText: password,
        cursorColor: Colors.grey,
        style: TextStyle(
          color: Colors.grey,
          fontSize: MediaQuery.of(context).size.width /
              MediaQuery.of(context).size.height *
              isMobile *
              16,
        ),
        decoration: InputDecoration.collapsed(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: MediaQuery.of(context).size.width /
                MediaQuery.of(context).size.height *
                isMobile *
                16,
            decorationStyle: TextDecorationStyle.solid,
          ),
          
        ),
        
      ),
    );
  }
}
