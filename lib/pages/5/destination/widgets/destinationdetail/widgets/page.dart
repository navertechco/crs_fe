import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../index.dart';
import '../index.dart';
import '../../index.dart';
import 'index.dart';

class DestinationDetailWidget extends GetView<DestinationDetailController> {
  DestinationDetailWidget(
      {Key? key,
      required this.destination,
      required this.type,
      required this.index,
      required this.ctrl})
      : super(key: key);
  final destination;
  final type;
  final index;
  final DestinationDetailController ctrl;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.10,
              left: MediaQuery.of(context).size.width * 0.05),
          child: LeftWidget(
            destination: destination,
            index: index,
          ),
        ),
        RightWidget(
            destination: destination,
            index: index,
            ctrl: ctrl,
            formKey: _formKey),
        Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.51,
              top: MediaQuery.of(context).size.height * 0.8),
          child: CustomKeypadWidget(
              nextlabel: "Next >",
              prevlabel: " < Previous",
              onNext: () {
                promoteDestination(ctrl, _formKey, destination, index, type);
              },
              onPrevious: () {
                Get.close(1);
              },
              width: 0.3),
        ),
      ],
    );
  }
}
