// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import '../index.dart';
import './index.dart';

class TourParametersFormPage extends GetView<StatelessWidget> {
  TourParametersFormPage({
    Key? key,
    this.ctrl,
  }) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final TourParametersController? ctrl;
  @override
  Widget build(BuildContext context) {
    return TourParametersForm(
        formKey: _formKey, state: ctrl!.state, profile: false);
  }
}
