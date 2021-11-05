// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:naver_trivia/common/index.dart';
import 'package:naver_trivia/pages/forgot/state.dart';

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextFieldName(text: "Email"),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: "test@email.com"),
            validator: EmailValidator(errorText: "Use a valid email!"),
            onSaved: (email) => state.email = email!,
          ),
        ],
      ),
    );
  }
}
