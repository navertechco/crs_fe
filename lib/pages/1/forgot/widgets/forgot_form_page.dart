import 'package:flutter/material.dart';
import '../index.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';

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
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: kDefaultPadding * 15),
              ForgotForm(formKey: _formKey, state: ctrl!.state),
              SizedBox(height: kDefaultPadding * 1),
              SizedBox(
                child: RoundedFormButton(
                  height: 0.06,
                  fontSize: 6,
                  color: Color.fromARGB(255, 115, 115, 115),
                  textColor: Colors.white70,
                  fontWeight: FontWeight.bold,
                  label: "Send",
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      ctrl!.onForgot(context, ctrl!.state.email);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
