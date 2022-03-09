import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../index.dart';

class LeftWidget extends StatelessWidget {
  const LeftWidget({
    Key? key,
    required this.destination,
    required this.index,
  }) : super(key: key);

  final destination;
  final index;

  @override
  Widget build(BuildContext context) {
    Rx<List> galleryData = Rx([]);
    List experiences = processCatalog("experiences");
    galleryData.value = experiences.where((experience) {
      var value = experience["value"]; 
      var dest = value["destination"].toString().toUpperCase();
      return dest == destination.toString().toUpperCase();
    }).toList();

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
