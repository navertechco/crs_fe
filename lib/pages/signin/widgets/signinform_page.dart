// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/constants.dart';
import '../controller.dart';
import 'index.dart';

class SigninFormPage extends GetView<StatelessWidget> {
  SigninFormPage({
    Key? key,
    this.ctrl,
  }) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final SigninController? ctrl;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ingreso",
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      const Text("¿Usted olvidó su usuario o contraseña ?"),
                      TextButton(
                        onPressed: () => Get.toNamed("/Forgot"),
                        child: const Text(
                          "!Lo olvidé!",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: kDefaultPadding * 2),
                SigninForm(formKey: _formKey, state: ctrl!.state),
                const SizedBox(height: kDefaultPadding * 2),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        ctrl!.onSignin(
                            ctrl!.state.username, ctrl!.state.password);
                      }
                    },
                    child: const Text("Ingresar"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
