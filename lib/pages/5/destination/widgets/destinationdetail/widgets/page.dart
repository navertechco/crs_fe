import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:naver_crs/pages/5/destination/widgets/dgallery/widgets/index.dart';
import '../../../../../index.dart';
import '../index.dart';
import '../../index.dart';
import 'index.dart';

class DestinationDetailWidget extends GetView<DestinationDetailController> {
  const DestinationDetailWidget({Key? key, this.destination}) : super(key: key);
  final destination;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        LeftWidget(destination: destination),
        RightWidget(destination: destination),
        Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.51,
              top: MediaQuery.of(context).size.height * 0.8),
          child: CustomKeypadWidget(
              nextlabel: "Next >",
              prevlabel: " < Previous",
              onNext: () {
                globalctx.promoted.add(destination);
                Get.close(1);
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


