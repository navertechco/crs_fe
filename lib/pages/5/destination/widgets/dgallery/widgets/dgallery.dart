// ignore_for_file: non_constant_identifier_names

import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../index.dart';
import '../index.dart';

class DGalleryWidget extends GetView<DGalleryController> {
  final List<dynamic> galleryData;
  DGalleryWidget({Key? key, required this.galleryData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> Gallery = [];

    for (var item in galleryData) {
      Gallery.add(GalleryItem(
        onTap: () {
          showModal(
              context: context,
              builder: (context) {
                return GestureDetector(
                  onTap: () {
                    Get.close(1);
                  },
                  child: SizedBox(
                    width: 100,
                    child: ContentLayoutWidget(
                        child: YoutubeWidget(
                          videoId: item["video"],
                        ),
                        text: "DGallery"),
                  ),
                );
              });
        },
        key: Key(item["title"]),
        image: item["image"],
        title: item["title"],
      ));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SizedBox(width: MediaQuery.of(context).size.width * 0.1),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            // ignore: prefer_const_literals_to_create_immutables
            children: Gallery,
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.1),
        ],
      ),
    );
  }
}

class GalleryItem extends StatelessWidget {
  final String image;
  final String title;
  final void Function() onTap;
  const GalleryItem({
    Key? key,
    required this.image,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            GestureDetector(
              onTap: onTap,
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * 0.6,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
