import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../index.dart';
import 'index.dart';

/// hello
class CustomerFormPage extends GetView<CustomerController> {
  final CustomerController? ctrl;
  const CustomerFormPage({Key? key, this.ctrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomCustomerDataForm(ctrl: ctrl),
    );
  }
}
