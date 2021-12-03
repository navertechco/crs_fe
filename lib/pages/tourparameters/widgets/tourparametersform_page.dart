// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:naver_crs/common/index.dart';  
import '../index.dart';
import './index.dart'; 

class TourParametersFormPage extends GetView<StatelessWidget> {
  TourParametersFormPage({
    Key? key,
    this.ctrl,
  }) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final TourParametersController? ctrl;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              SizedBox(
                  child: TourParametersForm(
                      formKey: _formKey, state: ctrl!.state, profile: false),
                  width: MediaQuery.of(context).size.width * 0.865),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              SizedBox(
                child: RoundedFormButton(
                  width: 0.4,
                  height: 0.08,
                  fontSize: MediaQuery.of(context).size.height * 0.01,
                  label: "Register",
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      // Sign up form is done
                      // It saved our inputs
                      _formKey.currentState!.save();

                      ctrl!.onTourParameters(
                          context,
                          ctrl!.state.identification,
                          ctrl!.state.username,
                          ctrl!.state.firstname,
                          ctrl!.state.lastname,
                          ctrl!.state.email,
                          ctrl!.state.phone,
                          ctrl!.state.password);
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
