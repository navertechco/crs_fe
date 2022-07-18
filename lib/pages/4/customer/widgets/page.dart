import 'package:flutter/material.dart';
import '../index.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';

/// hello
class CustomerFormPage extends GetView<CustomerController> {
  final CustomerController? ctrl;
  const CustomerFormPage({Key? key, this.ctrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.02),
      child: Center(
        child: CustomCustomerDataForm(ctrl: ctrl),
      ),
    );
  }
}
