import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../index.dart';

class LeftWidget extends StatelessWidget {
  const LeftWidget({
    Key? key,
    required this.destination,
  }) : super(key: key);

  final destination;

  @override
  Widget build(BuildContext context) {
    Rx<List> galleryData = Rx([]);

    getExperiences(destination, "", null, null, null);

    var experiences = getContext("experiences");
    galleryData.value = experiences;

    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
          top: MediaQuery.of(context).size.height * 0.3),
      child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width * 0.4,
          // color: Colors.blue[50],
          child: Obx(() {
            return GalleryWidget(galleryData: galleryData.value);
          })),
    );
  }
}
