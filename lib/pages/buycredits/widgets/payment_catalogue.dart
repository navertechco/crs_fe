import 'package:flutter/material.dart';
import 'package:naver_trivia/common/index.dart';
import 'package:naver_trivia/common/widgets/index.dart';

// ignore: must_be_immutable
class PaymentCatalogueWidget extends StatelessWidget {
  PaymentCatalogueWidget({Key? key, required this.payment}) : super(key: key);

  Object? payment;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        validator: (value) =>
            value == null ? 'El tipo de pago es requerido' : null,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        // validator: RequiredValidator(errorText: "Pago es requerido"),
        decoration: const InputDecoration(
            hintText: "Seleccione un tipo de pago",
            label: TextFieldName(text: "Tipo de Pago")),
        onSaved: (value) {
          setContext('payment', value);
          payment = value!;
        },
        // We also need to validate our password
        // Now if we type anything it adds that to our password
        onChanged: (value) {
          setContext('payment', value);
          payment = value!;
        },
        items: const [
          DropdownMenuItem(
            value: 1,
            child: Text("Efectivo"),
          ),
          DropdownMenuItem(
            value: 2,
            child: Text("Depósito"),
          ),
          DropdownMenuItem(
            value: 3,
            child: Text("Tránsferencia"),
          ),
          DropdownMenuItem(
            value: 4,
            child: Text("Saldo"),
          ),
        ]);
  }
}
