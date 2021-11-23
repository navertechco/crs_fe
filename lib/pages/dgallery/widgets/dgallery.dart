import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/index.dart';
import '../index.dart';

class DGalleryWidget extends GetView<DGalleryController> {
  const DGalleryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          SizedBox(width: Get.width * 0.1),
          const GalleryItem(
            image: "assets/custom/img/tucan.png",
          ),
          const GalleryItem(
            image: "assets/custom/img/tucan.png",
          ),
          const GalleryItem(
            image: "assets/custom/img/tucan.png",
          ),
          const GalleryItem(
            image: "assets/custom/img/tucan.png",
          ),
          const GalleryItem(
            image: "assets/custom/img/tucan.png",
          ),
          const GalleryItem(
            image: "assets/custom/img/tucan.png",
          ),
          const GalleryItem(
            image: "assets/custom/img/tucan.png",
          ),
          const GalleryItem(
            image: "assets/custom/img/tucan.png",
          ),
        ],
      ),
    );
  }
}

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
        Column(
          children: [
            SizedBox(height: Get.height * 0.2),
            Image.asset(image, height: Get.height * 0.5),
            SizedBox(height: Get.height * 0.05),
            RoundedFormButton(
              horizontal: 20,
              vertical: 20,
              width: 0.15,
              label: "Agregar",
              onTap: () {
                Get.toNamed("/Home");
              },
            ),
          ],
        ),
        SizedBox(width: Get.width * 0.05),
      ],
    );
  }
}
