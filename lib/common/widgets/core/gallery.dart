// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../pages/index.dart';
import '../../../pages/5/destination/widgets/dgallery/index.dart';

class GalleryWidget extends GetView<DGalleryController> {
  final galleryData;
  GalleryWidget({Key? key, required this.galleryData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> Gallery = [];

    if (galleryData != null && galleryData.isNotEmpty) {
      var index = 0;
      for (var item in galleryData) {
        var ctlg = CatalogDto(null,
            code: item["code"],
            description: item["description"],
            value: item["value"]);
        Gallery.add(GalleryItem(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return VideoItem(item: ctlg.value);
                });
          },
          key: Key(index.toString()),
          image: ctlg.value["image"],
          title: ctlg.value["title"],
        ));
        index++;
      }
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
