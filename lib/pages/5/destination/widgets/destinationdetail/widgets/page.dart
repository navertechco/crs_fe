import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../index.dart';
import '../index.dart';
import '../../index.dart';
import 'index.dart';

class DestinationDetailWidget extends GetView<DestinationDetailController> {
  DestinationDetailWidget({Key? key, this.destination, required this.ctrl})
      : super(key: key);
  final destination;
  final DestinationDetailController ctrl;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        LeftWidget(destination: destination),
        RightWidget(destination: destination, ctrl: ctrl, formKey: _formKey),
        Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.51,
              top: MediaQuery.of(context).size.height * 0.8),
          child: CustomKeypadWidget(
              nextlabel: "Next >",
              prevlabel: " < Previous",
              onNext: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  if (!globalctx.promoted.contains(destination)) {
                    globalctx.promoted.add(destination);
                    globalctx.memory["destinations"][destination] =
                        ctrl.state.toMap();
                  }
                  Get.close(1);
                }
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
