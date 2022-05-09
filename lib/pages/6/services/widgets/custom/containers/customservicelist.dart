// ignore_for_file: unused_local_variable, prefer_function_declarations_over_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../index.dart';

class CustomServicesListWidget extends StatelessWidget {
  final ServicesController ctrl;
  const CustomServicesListWidget({
    Key? key,
    required this.ctrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        // width: MediaQuery.of(context).size.width * 0.1,
        child: Column(children: [
      CustomTitleWidget(
          fontWeight: FontWeight.bold,
          label: "Suggested Services",
          color: Colors.white),
      const Divider(
        color: Colors.black,
        height: 20,
        thickness: 2,
        indent: 5,
        endIndent: 5,
      ),
      Scrollbar(
          child: SingleChildScrollView(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: Obx(() {
                    return Scrollbar(
                        child: SingleChildScrollView(
                            child: Column(
                                children: serviceSuggestedDragData.value)));
                  }))))
    ]));
  }
}
