import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../index.dart';
import 'widgets/index.dart';
import 'index.dart';

class DGalleryPage extends GetView<DGalleryController> {
  DGalleryPage({Key? key}) : super(key: key);

  Widget _buildView(BuildContext? _context) {
    var galleryData = [].obs;

    getDestinationExperiences("quito").then((value) {
      galleryData.value = value;
    });
    return GalleryLayoutWidget(
        child: Obx(() {
          return DGalleryWidget(galleryData: galleryData.value);
        }),
        text: "DGallery");
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // var session = getContext('session');
    // String name = session['firstname'] + " " + session['lastname'];
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: _key,
          endDrawer: const MenuWidget(),
          body: Stack(
            alignment: Alignment.center,
            children: [
              _buildView(context),
            ],
          ),
        ));
  }
}
