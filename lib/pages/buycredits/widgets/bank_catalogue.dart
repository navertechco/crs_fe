import 'package:flutter/material.dart';
import 'package:naver_trivia/common/widgets/index.dart';

// ignore: must_be_immutable
class BankCatalogueWidget extends StatelessWidget {
  BankCatalogueWidget({Key? key, required this.bank})
      : super(key: key);

  Object? bank;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        validator: (value) =>
            value == null ? 'El Banco es requerido' : null,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: const InputDecoration(
          hintText: "Seleccione un Banco",
          label: TextFieldName(text: "Banco"),
        ),
        onSaved: (value) => bank = value!,
        // We also need to validate our password
        // Now if we type anything it adds that to our password
        onChanged: (value) => bank = value!,
        items: const [
          DropdownMenuItem(
            value: "pichincha",
            child: Text("Pichincha"),
          ),
          DropdownMenuItem(
            value: "produbanco",
            child: Text("Produbanco"),
          ),
          
        ]);
  }
}
