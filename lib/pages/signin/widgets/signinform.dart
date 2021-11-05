import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/constants.dart';
import 'package:naver_crs/common/widgets/index.dart';
import 'package:naver_crs/pages/signin/state.dart';

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextFieldName(text: "Username"),
          TextFormField(
            decoration: const InputDecoration(hintText: "Username"),
            validator: RequiredValidator(errorText: "Username is required"),
            // Let's save our username
            onSaved: (username) => state.username = username!,
          ),
          const SizedBox(height: kDefaultPadding),
          const TextFieldName(text: "Password"),
          TextFormField(
            // We want to hide our password
            obscureText: true,
            decoration: const InputDecoration(hintText: "******"),
            validator: passwordValidator,
            onSaved: (password) => state.password = password!,
          ),
        ],
      ),
    );
  }
}
