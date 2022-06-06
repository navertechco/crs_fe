// ignore_for_file: unused_field
import 'package:flutter/material.dart';
import '../index.dart';
import 'package:naver_crs/index.dart';

// ignore: must_be_immutable
class ForgotForm extends StatelessWidget {
  ForgotForm({
    Key? key,
    required this.formKey,
    required this.state,
  }) : super(key: key);

  final GlobalKey formKey;
  final ForgotState state;
  late String _userName, _email, _password, _phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            child: RoundedFormTextField(
              onSaved: (value) => state.email = value!,
              hintText: 'Email',
              keyboardType: TextInputType.emailAddress,
            ),
          ),
        ],
      ),
    );
  }
}
