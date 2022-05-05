import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naver_crs/pages/6/services/widgets/servicecedetail/widgets/index.dart';

import '../../../../index.dart';

class ServiceRearOptionWidget extends StatelessWidget {
  const ServiceRearOptionWidget({Key? key, this.service = "coast"})
      : super(key: key);

  final String service;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Description",
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
            color: const Color.fromARGB(255, 204, 164, 61),
            fontSize: MediaQuery.of(context).size.width * 0.015,
            fontWeight: FontWeight.bold,
          )),
        ),
        GestureDetector(
          onTap: () {
            showCustomDialog(
                context, ServiceDetailWidget(service: service), "Close",
                buttonColor: Colors.white);
          },
          child: Text(
            "click here for details...\n",
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
              color: const Color.fromARGB(255, 204, 164, 61),
              fontSize: MediaQuery.of(context).size.width * 0.01,
              fontWeight: FontWeight.normal,
            )),
          ),
        ),
      ],
    );
  }
}
