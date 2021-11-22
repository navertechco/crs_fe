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
    return Form(
      key: widget.formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width / 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  child: RoundedFormField(
                    onSaved: (value) => widget.state.identification = value!,
                    hintText: 'Identification',
                  ),
                ),
                SizedBox(height: kDefaultPadding),
                SizedBox(
                  child: RoundedFormField(
                    onSaved: (value) => widget.state.identification = value!,
                    hintText: 'Names',
                  ),
                ),
                SizedBox(height: kDefaultPadding),
                SizedBox(
                  child: RoundedFormField(
                    onSaved: (value) => widget.state.surname = value!,
                    hintText: 'Surnames',
                  ),
                ),
                SizedBox(height: kDefaultPadding),
                SizedBox(
                  child: RoundedFormField(
                    onSaved: (value) => widget.state.lastname = value!,
                    hintText: 'Email',
                  ),
                ),
                SizedBox(height: kDefaultPadding),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  child: RoundedFormField(
                    onSaved: (value) => widget.state.identification = value!,
                    hintText: 'Phone',
                  ),
                ),
                SizedBox(height: kDefaultPadding),
                SizedBox(
                  child: RoundedFormField(
                    onSaved: (value) => widget.state.surname = value!,
                    hintText: 'Username',
                  ),
                ),
                SizedBox(height: kDefaultPadding),
                SizedBox(
                  child: RoundedFormField(
                    onSaved: (value) => widget.state.lastname = value!,
                    hintText: 'Password',
                  ),
                ),
                SizedBox(height: kDefaultPadding),
                SizedBox(
                  child: RoundedFormField(
                    onSaved: (value) => widget.state.lastname = value!,
                    hintText: 'Confirmation',
                  ),
                ),
                SizedBox(height: kDefaultPadding),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
