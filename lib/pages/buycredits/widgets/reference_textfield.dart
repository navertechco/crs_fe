// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:naver_crs/common/index.dart';
import 'package:naver_crs/common/widgets/index.dart';

// ignore: must_be_immutable
class ReferenceTextFieldWidget extends StatelessWidget {
  ReferenceTextFieldWidget({Key? key, required this.reference})
      : super(key: key);

  String? reference;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: "Detalle de Referencia",
        label: TextFieldName(text: "Referencia"),
      ),
      validator: RequiredValidator(errorText: "La Referencia es requerida"),
      // Let's save our reference
      onSaved: (value) {
        setContext('reference', value);
        reference = value.toString();
      },
      onChanged: (value) {
        setContext('reference', value);
        reference = value.toString();
      },
    );
  }
}
