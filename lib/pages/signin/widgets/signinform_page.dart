// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                SigninForm(formKey: _formKey, state: ctrl!.state),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                SizedBox(
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        ctrl!.onSignin(
                            ctrl!.state.username, ctrl!.state.password);
                      }
                    },
                    child: SvgPicture.asset(
                      "assets/custom/svg/images/IngresarButton.svg",
                      width: MediaQuery.of(context).size.width * 0.2,
                      // fit: BoxFit.fill,
                    ),
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
