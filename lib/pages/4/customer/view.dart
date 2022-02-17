import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/index.dart';
import 'index.dart';
import '../../index.dart';

class CustomerPage extends GetView<CustomerController> {
  const CustomerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
        body: _buildCustomerFormPage(context),
      ),
    );
  }
}

GetBuilder<CustomerController> _buildCustomerFormPage(
  BuildContext context,
) {
  return GetBuilder<CustomerController>(
    id: 'Customer_form_page',
    builder: (controller) => Stack(
      children: [
        ContentLayoutWidget(
            background: "assets/custom/img/customer.png",
            child: CustomerFormPage(ctrl: controller),
            text: "              "),
      ],
    ),
  );
}
