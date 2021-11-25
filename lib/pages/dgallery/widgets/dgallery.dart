import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/index.dart';
import 'package:naver_crs/pages/index.dart';
import '../index.dart';

// ignore: non_constant_identifier_names, prefer_function_declarations_over_variables
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
  const DGalleryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> Gallery = [];

    galeryData.forEach((item) {
      Gallery.add(GalleryItem(
        key: Key(item["title"]),
        image: item["image"],
        title: item["title"],
      ));
    });

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

  const GalleryItem({
    Key? key,
    required this.image,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Row(
      children: [
        Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.3),
            GestureDetector(
              onTap: () {
                print(key);
              },
              child: Image.asset(image,
                  height: MediaQuery.of(context).size.height * 0.4),
            ),
            RoundedFormButton(
              horizontal: 20,
              vertical: 20,
              width: 0.12,
              height: 0.04,
              fontSize: 20,
              label: title + " - Read More",
              onTap: () {
                Navigator.of(context).restorablePush(_modalBuilder, arguments: {
                  "title": title,
                  "image": image,
                });
              },
            ),
          ],
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.05),
      ],
    );
  }
}

Route<void> _modalBuilder(BuildContext context, Object? arguments) {
  return CupertinoModalPopupRoute<void>(
    builder: (BuildContext context) {
      return DestinationPage(args: arguments);
    },
  );
}
