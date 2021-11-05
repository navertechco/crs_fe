import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sweetalert/sweetalert.dart';

import '../controller.dart';

class BuyButtonWidget extends StatelessWidget {
  const BuyButtonWidget({
    Key? key,
    required this.formKey,
    required this.n,
    required this.ctrl,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final RxInt n;
  final BuyCreditsController ctrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Obx(() {
        return ElevatedButton(
          // onPressed: null,
          // ignore: unnecessary_null_comparison, unrelated_type_equality_checks
          onPressed: n == 0
              ? null
              : () {
                  if (formKey.currentState!.validate()) {
                    return SweetAlert.show(context,
                        title: "¿Desea comprar $n crédito${n > 1 ? 's' : ''} ?",
                        subtitle:
                            "Si el monto depositado supera lo comprado entonces se adicionará el excedente",
                        style: SweetAlertStyle.confirm,
                        showCancelButton: true, onPress: (bool isConfirm) {
                      if (isConfirm) {
                        ctrl.onBuyCredits(context);
                        formKey.currentState!.reset();
                        n.value = 0;
                        // return false to keep dialog
                        return false;
                      } else {
                        return null;
                      }
                    });
                  }
                },
          child: const Text("Comprar"),
        );
      }),
    );
  }
}
