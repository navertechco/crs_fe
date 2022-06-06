import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ServiceFrontOptionWidget extends StatelessWidget {
  const ServiceFrontOptionWidget({Key? key, required this.service})
      : super(key: key);
  final String service;
  @override
  Widget build(BuildContext context) {
    var title = '';

    if (service.contains("-")) {
      for (var item in service.toString().split("-")) {
        title += item.toString() + "\n";
      }
    } else {
      title += service;
    }

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
            color: Color.fromARGB(255, 128, 128, 128),
            fontSize: MediaQuery.of(context).size.width * 0.010,
            fontWeight: FontWeight.bold,
          )),
        ),
      ),
    );
  }
}
