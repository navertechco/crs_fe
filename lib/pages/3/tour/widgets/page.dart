// ignore_for_file: file_names, import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart'; 
import 'package:get/get.dart'; 
import '../index.dart';
import './index.dart';

class TourFormPage extends GetView<StatelessWidget> {
  TourFormPage({
    Key? key,
    this.ctrl,
  }) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final TourController? ctrl;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          LeftWidget(),
          RightWidget(formKey: _formKey, ctrl: ctrl, profile: false),
        ],
      ),
    );
  }
}
