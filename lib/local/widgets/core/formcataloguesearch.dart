// ignore_for_file: unused_local_variable, prefer_function_declarations_over_variables, unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../index.dart';
import 'package:dropdown_search/dropdown_search.dart';

// ignore: must_be_immutable
class FormCatalogueSearchWidget extends StatefulWidget {
  FormCatalogueSearchWidget(
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
  State<FormCatalogueSearchWidget> createState() =>
      _FormCatalogueSearchWidgetState();
}

class _FormCatalogueSearchWidgetState extends State<FormCatalogueSearchWidget> {
  @override
  Widget build(BuildContext context) {
    var items = getItems(widget.data, widget.value, widget.hintText);
    var initialValue = Rx(widget.value == "" ? "0" : widget.value);
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
                    child: Builder(builder: (context) {
                  if (items != null) {
                    
// DropdownButton<String>(
//                       hint: Text(widget.hintText ?? "Choose a Option"),
//                       style: KTextSytle(
//                               color: Colors.black,
//                               context: context,
//                               fontSize: widget.value == null
//                                   ? widget.fontSize
//                                   : widget.fontSize * 0.8 * isMobile,
//                               fontWeight: widget.value == null
//                                   ? FontWeight.normal
//                                   : FontWeight.bold)
//                           .getStyle(),
//                       alignment: Alignment.centerLeft,
//                       isExpanded: true,
//                       value: initialValue.value,
//                       onChanged: (value) {
//                         try {
//                           initialValue.value = value!;
//                           widget.disabled ? null : widget.onChanged(value);
//                         } catch (e) {
//                           log(e);
//                         }
//                       },
//                       items: items ?? <DropdownMenuItem<String>>[],
//                     );


                    return DropdownSearch(
                      items: ["Brazil", "France", "Tunisia", "Canada"],
                      dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration:
                              InputDecoration(labelText: "Name")),
                      onChanged: print,
                      selectedItem: "Tunisia",
                      validator: (String? item) {
                        if (item == null) {
                          return "Required field";
                        } else if (item == "Brazil") {
                          return "Invalid item";
                        } else {
                          return null;
                        }
                      },
                    );
                  } else {
                    return Text("");
                  }
                })),
              );
            },
          ));
    });
  }
}
