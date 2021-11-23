
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class GalleryItem extends StatelessWidget {
  final String image;

  const GalleryItem({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(image, height: Get.height * 0.4),
        SizedBox(width: Get.width * 0.05),
      ],
    );
  }
}
