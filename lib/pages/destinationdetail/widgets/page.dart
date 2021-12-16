import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naver_crs/common/index.dart';
import '../index.dart';

class DestinationDetailWidget extends GetView<DestinationDetailController> {
  const DestinationDetailWidget({Key? key, this.destination}) : super(key: key);
  final destination;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        LeftWidget(destination: destination),
        GestureDetector(
          onTap: () {
            globalctx.Completed.add(destination);
            Get.close(1);
          },
          child: RightWidget(destination: destination),
        ),
      ],
    );
  }
}

class LeftWidget extends StatelessWidget {
  const LeftWidget({
    Key? key,
    required this.destination,
  }) : super(key: key);

  final destination;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
          top: MediaQuery.of(context).size.height * 0.3),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width * 0.4,
        color: Colors.blue[50],
        child: Text(
          "$destination",
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
            color: const Color.fromARGB(255, 0, 0, 255),
            fontSize: MediaQuery.of(context).size.width * 0.04,
            fontWeight: FontWeight.bold,
          )),
        ),
      ),
    );
  }
}

class RightWidget extends StatelessWidget {
  const RightWidget({
    Key? key,
    required this.destination,
  }) : super(key: key);

  final destination;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.5,
          top: MediaQuery.of(context).size.height * 0.18),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width * 0.45,
        color: Colors.red[50],
        child: Text(
          "$destination",
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
            color: const Color.fromARGB(255, 0, 0, 255),
            fontSize: MediaQuery.of(context).size.width * 0.04,
            fontWeight: FontWeight.bold,
          )),
        ),
      ),
    );
  }
}
