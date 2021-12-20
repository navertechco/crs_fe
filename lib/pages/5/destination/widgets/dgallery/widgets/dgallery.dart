// ignore_for_file: non_constant_identifier_names

import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/index.dart';  
import '../index.dart';

List<Map<String, dynamic>> galeryData = [
  {
    "image": "assets/custom/img/tucan.png",
    "title": "Item 1",
  },
  {
    "image": "assets/custom/img/tucan.png",
    "title": "Item 2",
  },
  {
    "image": "assets/custom/img/tucan.png",
    "title": "Item 3",
  },
  {
    "image": "assets/custom/img/tucan.png",
    "title": "Item 4",
  },
  {
    "image": "assets/custom/img/tucan.png",
    "title": "Item 5",
  },
  {
    "image": "assets/custom/img/tucan.png",
    "title": "Item 6",
  },
  {
    "image": "assets/custom/img/tucan.png",
    "title": "Item 7",
  },
  {
    "image": "assets/custom/img/tucan.png",
    "title": "Item 8",
  },
  {
    "image": "assets/custom/img/tucan.png",
    "title": "Item 9",
  },
  {
    "image": "assets/custom/img/tucan.png",
    "title": "Item 10",
  },
  {
    "image": "assets/custom/img/tucan.png",
    "title": "Item 11",
  },
  {
    "image": "assets/custom/img/tucan.png",
    "title": "Item 12",
  },
];

class DGalleryWidget extends GetView<DGalleryController> {
  const DGalleryWidget({Key? key, destination}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> Gallery = [];
     
    for (var item in galeryData) { 
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
                        child: const YoutubeWidget(
                          videoId: "r7XhWUDj-Ts",
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
 