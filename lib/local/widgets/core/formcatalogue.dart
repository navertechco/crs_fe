// ignore_for_file: unused_local_variable, prefer_function_declarations_over_variables, unnecessary_null_comparison
import 'package:flutter/material.dart';
import '../../../index.dart';

// ignore: must_be_immutable
class FormCatalogueWidget extends StatelessWidget {
  FormCatalogueWidget(
      {Key? key,
      this.disabled = false,
      required this.value,
      required this.data,
      this.hintText = "Choose a Option",
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
  Widget build(BuildContext context) {
    var items = getItems(data, value, hintText);

    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: FormField<String>(
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration.collapsed(
                filled: false,
                hintText: hintText,
                hintStyle: KTextSytle(
                        color: Colors.black,
                        context: context,
                        fontSize: value == null
                            ? fontSize
                            : fontSize * 0.8 * isMobile,
                        fontWeight:
                            value == null ? FontWeight.normal : FontWeight.bold)
                    .getStyle(),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: Text(hintText!),
                  style: KTextSytle(
                          color: Colors.black,
                          context: context,
                          fontSize: value == null
                              ? fontSize
                              : fontSize * 0.8 * isMobile,
                          fontWeight: value == null
                              ? FontWeight.normal
                              : FontWeight.bold)
                      .getStyle(),
                  alignment: Alignment.centerLeft,
                  isExpanded: true,
                  value: value,
                  onChanged: disabled ? null : onChanged,
                  items: items,
                ),
              ),
            );
          },
        ));
  }
}

class T {}
