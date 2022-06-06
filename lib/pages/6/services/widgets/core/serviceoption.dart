import 'package:flutter/material.dart';
import '../index.dart';
import 'index.dart';

class ServiceOptionWidget extends StatelessWidget {
  const ServiceOptionWidget(
      {Key? key,
      required this.service,
      this.height = 80,
      this.width = 250,
      this.suggested = false})
      : super(key: key);
  final String service;
  final double height;
  final double width;
  final bool suggested;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
        child: GoldBorderWidget(
            child: SwitcherWidget(
                suggested: suggested,
                service: service,
                firstchild: ServiceFrontOptionWidget(service: service),
                seccondchild: ServiceRearOptionWidget(service: service))));
  }
}
