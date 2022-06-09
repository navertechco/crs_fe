// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../index.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';
import '../../../pages/5/destination/widgets/dgallery/index.dart';

class GalleryWidget extends GetView<DGalleryController> {
  final galleryData;
  final destination;
  const GalleryWidget({Key? key, required this.galleryData, this.destination})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> galleryList = [];
    var destData = getDestinationValueByName(destination);
    if (galleryData != null && galleryData.isNotEmpty) {
      var index = 0;
      for (var item in galleryData) {
        var ctlg = CatalogDto(null,
            code: item["code"],
            description: item["description"],
            value: item["value"]);
        galleryList.add(GalleryItem(
          data: item,
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

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      child: Column(
        children: [
          Text(destination.toString().toUpperCase(),
              style: KTextSytle(
                      context: context,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)
                  .getStyle()),
          Text("${destData[8]}",
              style: KTextSytle(
                      context: context,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey)
                  .getStyle()),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: galleryList,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
