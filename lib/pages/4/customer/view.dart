import 'package:flutter/material.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';
import 'widgets/index.dart';

class CustomerPage extends GetView<CustomerController> {
  const CustomerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: _buildCustomerFormPage(context),
        bottomNavigationBar: NavBarWidget(),
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
