import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/index.dart';
import 'package:naver_crs/common/widgets/index.dart';
import 'widgets/index.dart';
import 'index.dart';

class DGalleryPage extends GetView<DGalleryController> {
  DGalleryPage({Key? key}) : super(key: key);

  Widget _buildView(BuildContext? _context) {
    return const GalleryLayoutWidget(child: DGalleryWidget(), text: "DGallery");
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
            alignment: Alignment.center,
            children: [
              _buildView(context),
              // Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              //   Padding(
              //     padding: EdgeInsets.only(
              //         top: MediaQuery.of(context).size.height * 0.1,
              //         left: MediaQuery.of(context).size.width * 0.05,
              //         bottom: 0,
              //         right: 0),
              //     child: Text(
              //       "OUR DESTINATION GALLERY",
              //       style: TextStyle(
              //           color: Colors.white,
              //           fontSize: MediaQuery.of(context).size.width * 0.025,
              //           fontWeight: FontWeight.bold),
              //     ),
              //   ),
              // ]),
            ],
          ),
        ));
  }
}
