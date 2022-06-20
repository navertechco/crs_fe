import 'package:flutter/material.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';
import 'widgets/index.dart';

class NetRatePage extends GetView<NetRateController> {
  NetRatePage({Key? key}) : super(key: key);

  final Map<String, GlobalKey<State<StatefulWidget>>> keys = {
    "cover": GlobalKey(),
    "header": GlobalKey(),
    "dest": GlobalKey(),
    "end": GlobalKey()
  };

  Widget _buildView(BuildContext _context) {
    return ContentLayoutWidget(
        background: "assets/images/1x/resume.png",
        child: Stack(
          children: [
            NetRateWidget(pkeys: keys),
          ],
        ),
        text: '');
  }

  final _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        floatingActionButton: Stack(
          children: [
            Positioned(
              left: MediaQuery.of(context).size.width * 0.92,
              top: MediaQuery.of(context).size.height * 0.5,
              child: ScrollTopDownArrows(controller: _controller),
            ),
          ],
        ),
        body: Scrollbar(
            child: SingleChildScrollView(
          controller: _controller,
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 2,
              child: _buildView(context)),
        )),
      ),
    );
  }
}
