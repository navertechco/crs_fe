import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/index.dart';

import '../index.dart';
import 'index.dart';

/// hello
class CustomerWidget extends GetView<CustomerController> {
  const CustomerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: const CustomCustomerDataForm(),
    );
  }
}
