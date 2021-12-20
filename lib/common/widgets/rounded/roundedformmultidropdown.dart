// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class RoundedFormMultiDropdown extends StatelessWidget {
  final double left;
  final double top;
  final double width;
  final double height;
  final double fontSize;
  final String? hintText;
  final String? label;
  final void Function(List<Map<String, dynamic>>?) onSaved;
  final void Function(List<Map<String, dynamic>>?) onChanged;
  final List<Map<String, dynamic>> data;
  final List<Map<String, dynamic>>? value;

  RoundedFormMultiDropdown(
      {Key? key,
      required this.data,
      this.hintText,
      this.label,
      this.left = 0,
      this.top = 8,
      this.width = 0.2,
      this.height = 0.05,
      this.fontSize = 0.1,
      required this.onSaved,
      this.password = false,
      this.value = const [],
      required this.onChanged})
      : super(key: key);

  bool password;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * width,
      padding: EdgeInsets.only(left: left, top: top),
      child: MultiSelectDialogField(
        initialValue: value,
        title: Text(hintText!),
        // searchHint: hintText,
        buttonText: Text(hintText!,
            style:
                TextStyle(fontSize: MediaQuery.of(context).size.height * 0.02)),
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(50)),
        items: data.map((e) => MultiSelectItem(e, e["description"]!)).toList(),
        listType: MultiSelectListType.CHIP,
        onConfirm: onSaved,
        onSelectionChanged: onChanged,
      ),
    );
  }
}
