import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';
import 'widgets/index.dart';

class ExperiencesPage extends GetView<ExperiencesController> {
  const ExperiencesPage({Key? key}) : super(key: key);

  Widget _buildView(BuildContext? _context) {
    return ContentLayoutWidget(
        background: "assets/images/1x/layout.png",
        child: ExperiencesWidget(ctrl: controller),
        text: '');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: _buildView(context),
        bottomNavigationBar: NavBarWidget(),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     // Add your onPressed code here!
        //     showCustomDialog(context, CustomDayWidget(), "Close",
        //         buttonColor: Colors.white);
        //   },
        //   backgroundColor: Color.fromARGB(255, 204, 164, 61),
        //   child: const Icon(Icons.calendar_today_outlined),
        // )
      ),
    );
  }
}
