// ignore_for_file: must_be_immutable 
import 'package:flutter/material.dart';  
import '../index.dart';

class RoundedFormDropdown extends StatelessWidget {
  final double horizontal;
  final double vertical;
  final double width;
  final double height;
  final double fontSize;
  final String hintText;
  final void Function(String?)? onSaved;
  final List<Map<String, dynamic>> data;

  RoundedFormDropdown(
      {Key? key,
      required this.data,
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

    return Container(
      width: MediaQuery.of(context).size.width * width,
      height: MediaQuery.of(context).size.height * height,
      padding: EdgeInsets.symmetric(
        horizontal: horizontal,
        vertical: vertical,
      ),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(50)),
      child: FormCatalogueWidget(data: data, label: hintText),
    );
  }
}
