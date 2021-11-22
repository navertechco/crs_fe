import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../index.dart';

class DGalleryWidget extends GetView<DGalleryController> {
  const DGalleryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxInt purposecolor = 0xFF000000.obs;
    int yellow = 0xFFC7C7C7;
    return Center(
      widthFactor: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Title"),
        ],
      ),
    );
  }
}
