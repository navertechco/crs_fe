import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/pages/5/destination/widgets/dgallery/widgets/index.dart';
import '../../../../../index.dart';

class LeftWidget extends StatelessWidget {
  const LeftWidget({
    Key? key,
    required this.destination,
  }) : super(key: key);

  final destination;

  @override
  Widget build(BuildContext context) {
    var galleryData = [].obs;

    getDestinationExperiences(destination).then((value) {
      galleryData.value = value;
    });

    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
          top: MediaQuery.of(context).size.height * 0.3),
      child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width * 0.4,
          // color: Colors.blue[50],
          child: Obx(() {
            return DGalleryWidget(galleryData: galleryData.value);
          })),
    );
  }
}
