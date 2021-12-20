import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naver_crs/common/index.dart';

class RearOptionWidget extends StatelessWidget {
  const RearOptionWidget({Key? key, this.experience = "coast"})
      : super(key: key);

  final String experience;
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> experiences = getContext("experiences");
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
            child: Align(
              alignment: Alignment.topCenter,
              child: Stack(
                children: [
                  Text(
                    "\n\n\ndescripcion",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: MediaQuery.of(context).size.width * 0.01,
                      fontWeight: FontWeight.normal,
                    )),
                  ),
                  Text(
                    " Title",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: const Color.fromARGB(255, 204, 164, 61),
                      fontSize: MediaQuery.of(context).size.width * 0.02,
                      fontWeight: FontWeight.bold,
                    )),
                  ),
                ],
              ),
            ),
            width: MediaQuery.of(context).size.width * 0.24,
            height: MediaQuery.of(context).size.height * 0.1,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: Image.asset(
                experiences[experience][0],
                fit: BoxFit.fill,
              ).image,
            ))),
      ],
    );
  }
}
