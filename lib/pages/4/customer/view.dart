import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../index.dart';
import 'widgets/index.dart';

import 'index.dart';

class CustomerPage extends GetView<CustomerController> {
  const CustomerPage({Key? key}) : super(key: key);

  Widget _buildView(BuildContext? _context) {
    return ContentLayoutWidget(
        background: "assets/custom/img/customer.png",
        child: const CustomerWidget(),
        text: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildView(context),
    );
  }
}