// ignore_for_file: unused_field

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/constants.dart';
import 'package:naver_crs/common/widgets/index.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  final GlobalKey formKey;

  @override
  State<SettingsWidget> createState() => _SettingsState();
}

class _SettingsState extends State<SettingsWidget> {
  late String _nickName, _email, _phoneNumber;
  bool? _sound, _music, _informed;
  String? _password;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const TextFieldName(text: "NickName"),
        TextFormField(
          decoration: const InputDecoration(hintText: "NickName"),
          validator: RequiredValidator(errorText: "Nickname is required"),
          // Let's save our nickname
          onSaved: (nickname) => _nickName = nickname!,
        ),
        const SizedBox(height: kDefaultPadding),
        Row(
          children: [
            const TextFieldName(text: "Efectos de sonido"),
            CupertinoSwitch(
              value: _sound ?? false,
              onChanged: (value) {
                setState(() {
                  _sound = value;
                });
              },
            ),
          ],
        ),
        const SizedBox(height: kDefaultPadding),
        Row(
          children: [
            const TextFieldName(text: "Musica"),
            CupertinoSwitch(
              value: _music ?? false,
              onChanged: (value) {
                setState(() {
                  _music = value;
                });
              },
            ),
          ],
        ),
        const SizedBox(height: kDefaultPadding),
        Row(
          children: [
            const TextFieldName(text: "Mantenme informado "),
            CupertinoSwitch(
              value: _informed ?? false,
              onChanged: (value) {
                setState(() {
                  _informed = value;
                });
              },
            ),
          ],
        ),
      ]),
    );
  }
}

class SettingsFormWidget extends GetView<StatelessWidget> {
  SettingsFormWidget({
    Key? key,
  }) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: kDefaultPadding * 2),
              SettingsWidget(formKey: _formKey),
              const SizedBox(height: kDefaultPadding * 1),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Sign up form is done
                      // It saved our inputs
                      _formKey.currentState!.save();
                    }
                  },
                  child: const Text("Configurar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
