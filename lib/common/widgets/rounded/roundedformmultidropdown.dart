// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../index.dart';

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
  final String? Function(List<Map<String, dynamic>>?)? validator;

  RoundedFormMultiDropdown(
      {Key? key,
      required this.data,
      this.hintText,
      this.label,
      this.left = 0,
      this.top = 8,
      this.width = 0.2,
      this.height = 0.05,
      this.fontSize = 10,
      required this.onSaved,
      this.password = false,
      this.value = const [],
      required this.onChanged,
      this.validator})
      : super(key: key);

  bool password;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * width,
      padding: EdgeInsets.only(left: left, top: top),
      child: MultiSelectDialogField(
        searchable: true,
        validator: validator,
        initialValue: value,
        itemsTextStyle: KTextSytle(context, fontSize, FontWeight.normal),
        selectedItemsTextStyle:
            KTextSytle(context, fontSize, FontWeight.normal),
        searchTextStyle: KTextSytle(context, fontSize, FontWeight.normal),
        searchHintStyle: KTextSytle(context, fontSize, FontWeight.normal),
        title: Text(
          hintText!,
          style: KTextSytle(context, fontSize, FontWeight.normal),
        ),
        // searchHint: hintText,
        buttonText: Text(
          hintText!,
          style: KTextSytle(context, fontSize, FontWeight.normal),
        ),
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(50)),
        items: data.map((e) => MultiSelectItem(e, e["description"])).toList(),
        listType: MultiSelectListType.LIST,
        onConfirm: onChanged,
        onSelectionChanged: onChanged,
        onSaved: onSaved,
      ),
    );
  }
}
