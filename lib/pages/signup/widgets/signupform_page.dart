import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/constants.dart';
import 'package:naver_crs/pages/signup/widgets/index.dart';

import '../../index.dart';

class SignupFormPage extends GetView<StatelessWidget> {
  SignupFormPage({
    Key? key,
    this.ctrl,
  }) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final SignupController? ctrl;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Registrarse",
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  const Text("¿Tiene una cuenta creada?"),
                  TextButton(
                    onPressed: () => Get.toNamed("/Signin"),
                    child: const Text(
                      "¡Ingresar!",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: kDefaultPadding * 2),
              SignUpForm(formKey: _formKey, state: ctrl!.state, profile: false),
              const SizedBox(height: kDefaultPadding * 1),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Sign up form is done
                      // It saved our inputs
                      _formKey.currentState!.save();

                      ctrl!.onSignup(
                          context,
                          ctrl!.state.identification,
                          ctrl!.state.username,
                          ctrl!.state.surname,
                          ctrl!.state.lastname,
                          ctrl!.state.email,
                          ctrl!.state.phone,
                          ctrl!.state.password);
                    }
                  },
                  child: const Text("Registrar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
