import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../index.dart';
import 'widgets/index.dart';
import 'index.dart';

class ExperiencesPage extends GetView<ExperiencesController> {
  const ExperiencesPage({Key? key}) : super(key: key);

  Widget _buildView(BuildContext? _context) {
    return ContentLayoutWidget(
        background: "assets/custom/img/layout.png",
        child: ExperiencesWidget(ctrl: controller),
        text: "");
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
