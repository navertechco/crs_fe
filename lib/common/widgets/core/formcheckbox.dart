import 'package:flutter/material.dart';
import '../index.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class FormCheckboxWidget extends StatelessWidget {
  FormCheckboxWidget(
      {Key? key,
      required this.value,
      required this.data,
      this.hintText = "Choose a Option",
      required this.onChanged,
      required this.onSaved})
      : super(key: key);

  List<Map<String, dynamic>> data;
  final String? hintText;
  void Function(dynamic) onSaved;
  final onChanged;
  final String? value;
  @override
  Widget build(BuildContext context) {
    Rx<String?> rxval = Rx(value);

    return DropdownButtonHideUnderline(
      child: Row(
        children: [
          Radio(value: rxval, groupValue: null, onChanged: onChanged),
          CustomFormLabelWidget(
              label: hintText!, fontWeight: FontWeight.normal),
        ],
      ),
    );
  }
}
