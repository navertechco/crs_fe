import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naver_crs/common/widgets/index.dart';
import 'widgets/index.dart';

import 'index.dart';

class ResumePage extends GetView<ResumeController> {
  ResumePage({Key? key}) : super(key: key);

  Widget _buildView(BuildContext? _context) {
    return ContentLayoutWidget(
        background: "assets/custom/img/resume.png",
        child: const ResumeWidget(),
        text: "");
  }

  final _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          floatingActionButton: Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.5),
            child: Column(
              children: [
                TextButton(
                    onPressed: () {
                      _controller.jumpTo(_controller.position.minScrollExtent);
                    },
                    child: Text("\u2191",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.normal,
                        )))),
                TextButton(
                    onPressed: () {
                      _controller.jumpTo(_controller.position.maxScrollExtent);
                    },
                    child: Text("\u2193",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.normal,
                        )))),
              ],
            ),
          ),
          body: Scrollbar(
            child: SingleChildScrollView(
              controller: _controller,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 2,
                  child: _buildView(context)),
            ),
          )),
    );
  }
}
