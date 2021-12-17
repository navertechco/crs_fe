import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naver_crs/common/index.dart';
import 'package:naver_crs/pages/destination/widgets/index.dart';
import 'package:naver_crs/pages/dgallery/widgets/index.dart';
import '../index.dart';

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
                globalctx.Completed.add(destination);
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

class LeftWidget extends StatelessWidget {
  const LeftWidget({
    Key? key,
    required this.destination,
  }) : super(key: key);

  final destination;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
          top: MediaQuery.of(context).size.height * 0.3),
      child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width * 0.4,
          color: Colors.blue[50],
          child: DGalleryWidget(destination: destination)),
    );
  }
}

class RightWidget extends StatelessWidget {
  const RightWidget({
    Key? key,
    required this.destination,
  }) : super(key: key);

  final destination;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.5,
          top: MediaQuery.of(context).size.height * 0.18),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width * 0.45,
        color: Colors.red[50],
        child: SingleChildScrollView(
          child: CustomStarDestinationForm(destination: destination),
        ),
      ),
    );
  }
}
