import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/index.dart';
import 'package:naver_crs/common/widgets/index.dart';
import 'widgets/index.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'index.dart';

class DGalleryPage extends GetView<DGalleryController> {
  DGalleryPage({Key? key}) : super(key: key);

  Widget _buildView(BuildContext? _context) {
    return const ProfileLayoutWidget(child: DGalleryWidget(), text: "DGallery");
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // var session = getContext('session');
    // String name = session['surname'] + " " + session['lastname'];
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: _key,
          endDrawer: MenuWidget(),
          body: Stack(
            children: [
              _buildView(context),
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Padding(
                  padding: const EdgeInsets.all(80.0),
                  child: Text(
                    "OUR DESTINATION GALLERY",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Get.width * 0.05,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ]),
            ],
          ),
        ));
  }
}
