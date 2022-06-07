import 'package:flutter/material.dart';
import '../index.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';

class DGalleryPage extends GetView<DGalleryController> {
  final destination;
  DGalleryPage({Key? key, this.destination}) : super(key: key);

  Widget _buildView(BuildContext? _context) {
    Rx<Map> galleryData = Rx({});

    galleryData.value = getContext('Experiences');

    return GalleryLayoutWidget(
        child: Obx(() {
          var d = arrivalDate.value;
          return GalleryWidget(galleryData: galleryData.value);
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
