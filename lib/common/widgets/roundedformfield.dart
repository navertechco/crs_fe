import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoundedFormField extends StatelessWidget {
  RoundedFormField(
      {Key? key,
      required this.hintText,
      this.horizontal = 30,
      this.vertical = 30,
      this.width = 0.3,
      required this.onSaved,
      this.password = false})
      : super(key: key);

  final double horizontal;
  final double vertical;
  final double width;
  final String hintText;
  final void Function(String?)? onSaved;
  bool password;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * width,
      padding: EdgeInsets.symmetric(
        horizontal: horizontal,
        vertical: vertical,
      ),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(36)),
      child: TextFormField(
        cursorColor: Colors.grey,
        style: const TextStyle(
          color: Colors.grey,
        ),
        decoration: InputDecoration.collapsed(
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          hintText: hintText,
        ),
        onSaved: onSaved,
        obscureText: password,
      ),
    );
  }
}
