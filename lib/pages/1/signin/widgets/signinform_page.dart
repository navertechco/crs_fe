// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import '../index.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';
import '../controller.dart';

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
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * isMobile * 0.05),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    height:
                        MediaQuery.of(context).size.height * isMobile * 0.3),
                SigninForm(formKey: _formKey, state: ctrl!.state),
                SizedBox(
                    height:
                        MediaQuery.of(context).size.height * isMobile * 0.05),
                SizedBox(
                  width: MediaQuery.of(context).size.width * isMobile * 0.2,
                  child: RoundedFormButton(
                    fontSize: 10,
                    color: Colors.white,
                    label: "SignIn",
                    height: 0.05,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        await ctrl!.onSignin(context, ctrl!.state.username,
                            ctrl!.state.password);
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => Get.toNamed("/Forgot"),
                    child: const Text(
                      "forgot password?",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
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
