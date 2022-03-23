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
    galleryData.value = experiences.where((experience) {
      var value = experience["value"];
      var dest = value["destination"].toString().toUpperCase();
      return dest == destination.toString().toUpperCase();
    }).toList();

    return Obx(() {
      return GalleryWidget(
          galleryData: galleryData.value, destination: destination);
    });
  }
}
