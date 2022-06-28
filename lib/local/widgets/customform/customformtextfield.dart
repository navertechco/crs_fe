import 'package:flutter/material.dart';
import '../index.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class CustomFormTextFieldWidget extends StatelessWidget {
  CustomFormTextFieldWidget({
    Key? key,
    this.label = '',
    this.hintText = '',
    this.keyboardType = TextInputType.text,
    this.validator,
    this.width = 0.2,
    this.fontSize = 10,
    this.height = 0.05,
    this.disabled = false,
    this.value,
    required this.onSaved,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.onChanged,
    this.onBack,
  }) : super(key: key);
  final fontSize;
  final String label;
  final String hintText;
  final double width;
  final double height;
  final TextInputType? keyboardType;
  String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  void Function(String?)? onBack;
  final void Function(String?)? onFieldSubmitted;
  final bool disabled;
  final value;
  List<TextInputFormatter>? inputFormatters;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CustomFormLabelWidget(
              fontSize: fontSize, label: label, fontWeight: FontWeight.normal),
          RawKeyboardListener(
            focusNode: FocusNode(),
            onKey: (event) {
              if (event.logicalKey == LogicalKeyboardKey.backspace) {
                onBack!(value);
              }
            },
            child: RoundedFormTextField(
                fontSize: fontSize * 1.0,
                initialValue: value.toString(),
                disabled: disabled,
                onSaved: onSaved,
                onChanged: onChanged,
                onFieldSubmitted: onFieldSubmitted,
                hintText: hintText,
                keyboardType: keyboardType,
                inputFormatters: inputFormatters,
                validator: validator,
                width: width,
                height: height),
          ),
        ],
      ),
    );
  }
}
