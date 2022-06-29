// ignore_for_file: unused_local_variable, prefer_function_declarations_over_variables, unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../index.dart';

// ignore: must_be_immutable
class FormCatalogueWidget extends StatefulWidget {
  FormCatalogueWidget(
      {Key? key,
      this.disabled = false,
      required this.value,
      required this.data,
      this.hintText,
      required this.onChanged,
      required this.onSaved,
      this.validator,
      this.fontSize = 10})
      : super(key: key);
  final fontSize;
  List<Map<String, dynamic>> data;
  final String? hintText;
  void Function(String?) onSaved;
  void Function(String?) onChanged;
  final String value;
  final bool disabled;
  final String? Function(String?)? validator;

  @override
  State<FormCatalogueWidget> createState() => _FormCatalogueWidgetState();
}

class _FormCatalogueWidgetState extends State<FormCatalogueWidget> {
  @override
  Widget build(BuildContext context) {
    var items = getItems(widget.data, widget.value, widget.hintText);
    var initialValue = Rx(widget.value);
    return Obx(() {
      var t = initialValue.value;
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: FormField<String>(
            builder: (FormFieldState<String> state) {
              return InputDecorator(
                decoration: InputDecoration.collapsed(
                  filled: false,
                  hintText: widget.hintText,
                  hintStyle: KTextSytle(
                          color: Colors.black,
                          context: context,
                          fontSize: widget.value == null
                              ? widget.fontSize
                              : widget.fontSize * 0.8 * isMobile,
                          fontWeight: widget.value == null
                              ? FontWeight.normal
                              : FontWeight.bold)
                      .getStyle(),
                ),
                child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                  hint: Text(widget.hintText ?? "Choose a Option"),
                  style: KTextSytle(
                          color: Colors.black,
                          context: context,
                          fontSize: widget.value == null
                              ? widget.fontSize
                              : widget.fontSize * 0.8 * isMobile,
                          fontWeight: widget.value == null
                              ? FontWeight.normal
                              : FontWeight.bold)
                      .getStyle(),
                  alignment: Alignment.centerLeft,
                  isExpanded: true,
                  value: initialValue.value,
                  onChanged: (value) {
                    initialValue.value = value!;
                    widget.disabled ? null : widget.onChanged(value);
                  },
                  items: items,
                )),
              );
            },
          ));
    });
  }
}

class T {}
