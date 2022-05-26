// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../index.dart';
import 'index.dart';

class ServiceDetailWidget extends GetView<ServiceDetailController> {
  const ServiceDetailWidget({Key? key, this.service}) : super(key: key);
  final service;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.0,
                top: MediaQuery.of(context).size.height * 0.0),
            child: Column(
              children: [
                TitleWidget(service: service),
                CarouselWidget(service: service),
                DescriptionWidget(service: service),
                // if (getServiceState(service) != "suggested")
                //   KeypadWidget(service: service),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
