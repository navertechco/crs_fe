import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/constants.dart';

import '../../index.dart';
import 'index.dart';

class ForgotFormPage extends GetView<StatelessWidget> {
  ForgotFormPage({
    Key? key,
    this.ctrl,
  }) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final ForgotController? ctrl;
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
                "Olvidó su usuario o contraseña",
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: kDefaultPadding * 20),
              ForgotForm(formKey: _formKey, state: ctrl!.state),
              const SizedBox(height: kDefaultPadding * 2),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Sign up form is done
                      // It saved our inputs
                      _formKey.currentState!.save();
                      ctrl!.onForgot(context, ctrl!.state.email);
                    }
                  },
                  child: const Text("Enviar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
