import 'package:flutter/material.dart';
import 'package:sweetalertv2/sweetalertv2.dart';
import '../index.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';

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
    return SingleChildScrollView(
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.10,
                left: MediaQuery.of(context).size.width * 0.04),
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
                  var hotelName = getFormValue(globalctx.memory["destinations"],
                      index.toString(), "hotelName", null);
                  if (hotelName == null) {
                    SweetAlertV2.show(context,
                        curve: ElasticInCurve(),
                        title: "Hotel Information is Required",
                        style: SweetAlertV2Style.error,
                        onPress: (bool isConfirm) {
                      Get.close(1);
                      return false;
                    });
                  } else {
                    promoteDestination(
                        ctrl, _formKey, destination, index, type);
                  }
                },
                onPrevious: () {
                  Get.close(1);
                },
                width: 0.3),
          ),
        ],
      ),
    );
  }
}
