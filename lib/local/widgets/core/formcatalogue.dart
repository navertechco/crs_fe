// ignore_for_file: unused_local_variable, prefer_function_declarations_over_variables, unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../index.dart';

// ignore: must_be_immutable
class FormCatalogueWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    var items = getItems(data, value, hintText);
    var initialValue = Rx(value == "" ? "0" : value);
    return Obx(() {
      var t = initialValue.value;
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: InputDecorator(
            decoration: InputDecoration.collapsed(
              filled: false,
              hintText: hintText,
              hintStyle: KTextSytle(
                      color: Colors.black,
                      context: context,
                      fontSize:
                          value == null ? fontSize : fontSize * 0.8 * isMobile,
                      fontWeight:
                          value == null ? FontWeight.normal : FontWeight.bold)
                  .getStyle(),
            ),
            child: FormField(
                validator: (value) => validator!(initialValue.value),
                builder: (context) {
                  return DropdownButtonHideUnderline(
                      child: Builder(builder: (context) {
                    if ((items != null ||
                        items.isNotEmpty ||
                        items.where((item) {
                              return item.value == initialValue.value;
                            }).length ==
                            1)) {
                      return DropdownButton<String>(
                        hint: Text(hintText ?? "Choose a Option"),
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
                        value: initialValue.value,
                        onChanged: (value) {
                          try {
                            initialValue.value = value!;
                            disabled ? null : onChanged(value);
                          } catch (e) {
                            log(e);
                          }
                        },
                        items: items,
                      );
                    } else {
                      return Text("");
                    }
                  }));
                }),
          ));
    });
  }
}

class T {}
