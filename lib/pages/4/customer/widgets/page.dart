import 'package:flutter/material.dart';
import '../index.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';
import 'package:naver_crs/index.dart';

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
