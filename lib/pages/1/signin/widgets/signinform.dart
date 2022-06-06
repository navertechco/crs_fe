import 'package:flutter/material.dart';
import '../index.dart';
import 'package:naver_crs/index.dart';

// ignore: must_be_immutable
class SigninForm extends StatelessWidget {
  SigninForm({
    Key? key,
    required this.formKey,
    required this.state,
  }) : super(key: key);

  final GlobalKey formKey;
  SigninState state;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            child: RoundedFormTextField(
              initialValue: "jcuevas2",
              onSaved: (value) => state.username = value!,
              hintText: 'Username',
            ),
          ),
          SizedBox(height: kDefaultPadding),
          SizedBox(
            child: RoundedFormTextField(
                initialValue: "jcuevas123!",
                onSaved: (value) => state.password = value!,
                hintText: 'Password',
                password: true),
          ),
        ],
      ),
    );
  }
}
