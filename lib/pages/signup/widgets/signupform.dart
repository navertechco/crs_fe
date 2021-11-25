// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/constants.dart';
import 'package:naver_crs/common/index.dart';
import 'package:naver_crs/common/widgets/index.dart';
import 'package:naver_crs/pages/signup/state.dart';

class SignUpForm extends StatefulWidget {
  SignUpForm({
    Key? key,
    required this.formKey,
    required this.state,
    required this.profile,
  }) : super(key: key);

  final GlobalKey formKey;
  final bool profile;
  SignupState state;
  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  @override
  Widget build(BuildContext context) {
    var session = getContext('session');
    var isMobile = isMobileDevice() ? 1 : 2.5;
    double width = 0.4;
    double height = 0.08;
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 4.5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
              SizedBox(
                child: RoundedFormField(
                  height: height,
                  width: width,
                  onSaved: (value) => widget.state.identification = value!,
                  hintText: 'Identification',
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
              SizedBox(
                child: RoundedFormField(
                  height: height,
                  width: width,
                  onSaved: (value) => widget.state.phone = value!,
                  hintText: 'Phone',
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
              SizedBox(
                child: RoundedFormField(
                  height: height,
                  width: width,
                  onSaved: (value) => widget.state.name = value!,
                  hintText: 'Name',
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
              SizedBox(
                child: RoundedFormField(
                  height: height,
                  width: width,
                  onSaved: (value) => widget.state.surname = value!,
                  hintText: 'Surname',
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
              SizedBox(
                child: RoundedFormField(
                  height: height,
                  width: width,
                  onSaved: (value) => widget.state.username = value!,
                  hintText: 'Username',
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
              SizedBox(
                child: RoundedFormField(
                  height: height,
                  width: width,
                  onSaved: (value) => widget.state.email = value!,
                  hintText: 'e-Mail',
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
              SizedBox(
                child: RoundedFormField(
                  height: height,
                  width: width,
                  onSaved: (value) => widget.state.password = value!,
                  hintText: 'Password',
                  password: true,
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
              SizedBox(
                child: RoundedFormField(
                  height: height,
                  width: width,
                  onSaved: (value) => widget.state.confirmation = value!,
                  hintText: 'Confirmation',
                  password: true,
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
            ],
          ),
        ],
      ),
    );
  }
}
