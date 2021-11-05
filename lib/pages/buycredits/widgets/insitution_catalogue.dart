import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/index.dart';
import 'package:naver_crs/common/widgets/index.dart';

// ignore: must_be_immutable
class InstitutionCatalogueWidget extends StatelessWidget {
  InstitutionCatalogueWidget({Key? key, required this.institution})
      : super(key: key);

  String? institution;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        validator: (value) =>
            value == null ? 'La insitución es requerida' : null,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: const InputDecoration(
          hintText: "Seleccione una institución",
          label: TextFieldName(text: "Institución"),
        ),
        onSaved: (value) {
          setContext('institution', value);
          institution = value.toString();
        },
        // We also need to validate our password
        // Now if we type anything it adds that to our password
        onChanged: (value) {
          setContext('institution', value);
          institution = value.toString();
        },
        items: const [
          DropdownMenuItem(
            value: 1,
            child: Text("Western Union"),
          ),
          DropdownMenuItem(
            value: 2,
            child: Text("ServiPagos"),
          ),
          DropdownMenuItem(
            value: 3,
            child: Text("DePratti"),
          ),
          DropdownMenuItem(
            value: 4,
            child: Text("Tuenti"),
          ),
          DropdownMenuItem(
            value: 5,
            child: Text("Movistar"),
          ),
          DropdownMenuItem(
            value: 6,
            child: Text("Claro"),
          ),
          DropdownMenuItem(
            value: 7,
            child: Text("Banco"),
          ),
        ]);
  }
}
