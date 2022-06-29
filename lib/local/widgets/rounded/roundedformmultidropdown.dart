// ignore_for_file: must_be_immutable, unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:naver_crs/index.dart';

class RoundedFormMultiDropdown extends StatelessWidget {
  final double left;
  final double top;
  final width;
  final height;
  final fontSize;
  final hintText;
  final String? label;
  final onSaved;
  final onChanged;
  final List<Map<String, dynamic>> data;
  final List<String> value;
  final String? Function(dynamic)? validator;
  final enabled;
  RoundedFormMultiDropdown(
      {Key? key,
      this.data = const [],
      this.hintText = '',
      this.label = '',
      this.left = 0,
      this.top = 0,
      this.width = 0.2,
      this.height = 0.0,
      this.fontSize = 5,
      this.onSaved,
      this.enabled = true,
      this.value = const [],
      this.onChanged,
      this.validator})
      : super(key: key);
  var dataSource = [];
  var dataValue = [];
  @override
  Widget build(BuildContext context) {
    var result = updateMulitDropdown(data, value, dataSource, dataValue);
    dataValue = result[0];
    dataSource = result[1];
    return SizedBox(
      width: MediaQuery.of(context).size.width * isMobile * 0.24,
      child: MultiSelectFormField(
        enabled: enabled ?? true,
        autovalidate: AutovalidateMode.disabled,
        chipBackGroundColor: Colors.grey,
        fillColor: Color.fromARGB(0, 255, 255, 255),
        chipLabelStyle: TextStyle(
            fontSize: isMobile * fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.black),
        dialogTextStyle: TextStyle(
            fontSize: isMobile * fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.black),
        checkBoxActiveColor: Colors.grey,
        checkBoxCheckColor: Colors.black,
        dialogShapeBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        title: Text(
          hintText!,
          style: TextStyle(fontSize: fontSize * 1.0, color: Colors.grey),
        ),
        validator: (value) {
          if (value == null || value.length == 0) {
            return 'Please select one or more options';
          }
          validator!(value);
          return null;
        },
        dataSource: dataSource,
        textField: 'display',
        valueField: 'value',
        okButtonLabel: 'OK',
        cancelButtonLabel: 'CANCEL',
        hintWidget: Text(
          "Select a Option",
          style: TextStyle(fontSize: fontSize * 1.0, color: Colors.grey),
        ),
        initialValue: dataValue,
        onSaved: onSaved,
        change: onChanged,
        open: onChanged,
        close: onChanged,
      ),
    );
  }
}
