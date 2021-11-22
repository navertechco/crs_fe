import 'package:flutter/material.dart';
import 'package:get/get.dart';


class RoundedFormField extends StatelessWidget {
  RoundedFormField(
      {Key? key,
      required this.hintText,
      required this.onSaved,
      this.password = false})
      : super(key: key);

  final String hintText;
  final void Function(String?)? onSaved;
  bool password;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.3,
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 30,
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
