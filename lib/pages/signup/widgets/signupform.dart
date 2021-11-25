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
    double width = 0.2;
    double height = 0.08;
    return Form(
      key: widget.formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 6),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 4.5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(
                  flex: 1,
                ),
                SizedBox(
                  child: RoundedFormField(
                    height: height,
                    width: width,
                    onSaved: (value) => widget.state.identification = value!,
                    hintText: 'Identification',
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
                SizedBox(
                  child: RoundedFormField(
                    height: height,
                    width: width,
                    onSaved: (value) => widget.state.phone = value!,
                    hintText: 'Phone',
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(
                  flex: 1,
                ),
                SizedBox(
                  child: RoundedFormField(
                    height: height,
                    width: width,
                    onSaved: (value) => widget.state.name = value!,
                    hintText: 'Name',
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
                SizedBox(
                  child: RoundedFormField(
                    height: height,
                    width: width,
                    onSaved: (value) => widget.state.surname = value!,
                    hintText: 'Surname',
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(
                  flex: 1,
                ),
                SizedBox(
                  child: RoundedFormField(
                    height: height,
                    width: width,
                    onSaved: (value) => widget.state.username = value!,
                    hintText: 'Username',
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
                SizedBox(
                  child: RoundedFormField(
                    height: height,
                    width: width,
                    onSaved: (value) => widget.state.email = value!,
                    hintText: 'e-Mail',
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(
                  flex: 1,
                ),
                SizedBox(
                  child: RoundedFormField(
                    height: height,
                    width: width,
                    onSaved: (value) => widget.state.password = value!,
                    hintText: 'Password',
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
                SizedBox(
                  child: RoundedFormField(
                    height: height,
                    width: width,
                    onSaved: (value) => widget.state.confirmation = value!,
                    hintText: 'Confirmation',
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
