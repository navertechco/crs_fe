// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextFieldName(text: "Identification"),
          TextFormField(
            readOnly: widget.profile,
            initialValue: session['identification'],
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: "1254735261"),
            validator: idValidator,
            onSaved: (identification) =>
                widget.state.identification = identification!,
          ),
          const SizedBox(height: kDefaultPadding),
          const TextFieldName(text: "Surname"),
          TextFormField(
            readOnly: widget.profile,
            initialValue: session['surname'],
            decoration: const InputDecoration(hintText: "Surname"),
            validator: RequiredValidator(errorText: "Surname is required"),
            // Let's save our username
            onSaved: (surname) => widget.state.surname = surname!,
          ),
          const SizedBox(height: kDefaultPadding),
          const TextFieldName(text: "Lastname"),
          TextFormField(
            readOnly: widget.profile,
            initialValue: session['lastname'],
            decoration: const InputDecoration(hintText: "Lastname"),
            validator: RequiredValidator(errorText: "Lastname is required"),
            // Let's save our username
            onSaved: (lastname) => widget.state.lastname = lastname!,
          ),
          const SizedBox(height: kDefaultPadding),
          const TextFieldName(text: "Username"),
          TextFormField(
            readOnly: widget.profile,
            initialValue: session['username'],
            decoration: const InputDecoration(hintText: "Username"),
            validator: RequiredValidator(errorText: "Username is required"),
            // Let's save our username
            onSaved: (username) => widget.state.username = username!,
          ),
          const SizedBox(height: kDefaultPadding),
          // We will fixed the error soon
          // As you can see, it's a email field
          // But no @ on keybord
          const TextFieldName(text: "Email"),
          TextFormField(
            readOnly: widget.profile,
            initialValue: session['email'],
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: "test@email.com"),
            validator: EmailValidator(errorText: "Use a valid email!"),
            onSaved: (email) => widget.state.email = email!,
          ),
          const SizedBox(height: kDefaultPadding),
          const TextFieldName(text: "Phone"),
          // Same for phone number
          TextFormField(
            readOnly: widget.profile,
            initialValue: session['phone'],
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(hintText: "+123487697"),
            validator: RequiredValidator(errorText: "Phone number is required"),
            onSaved: (phone) => widget.state.phone = phone!,
          ),
          const SizedBox(height: kDefaultPadding),
          const TextFieldName(text: "Password"),

          TextFormField(
            // We want to hide our password
            obscureText: true,
            decoration: const InputDecoration(hintText: "******"),
            validator: passwordValidator,
            onSaved: (password) => widget.state.password = password!,
            // We also need to validate our password
            // Now if we type anything it adds that to our password
            onChanged: (pass) => widget.state.password = pass,
          ),
          const SizedBox(height: kDefaultPadding),
          const TextFieldName(text: "Confirm Password"),
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(hintText: "*****"),
            validator: (pass) => MatchValidator(
                    errorText: "Password do not  match")
                .validateMatch(
                    pass!,
                    // ignore: prefer_if_null_operators
                    widget.state.password == null ? "" : widget.state.password),
            onSaved: (password) => widget.state.password = password!,
          ),
        ],
      ),
    );
  }
}
