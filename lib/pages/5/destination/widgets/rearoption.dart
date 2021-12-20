import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../index.dart';

class RearOptionWidget extends StatelessWidget {
  const RearOptionWidget(
      {Key? key,
      this.destination = "coast",
      this.description =
          """Lorem Ipsum is simply dummy text of the printing and typesetting 
industry. Lorem Ipsum has been but also the leap into electronic 
typesetting, Lorem Ipsum has been but also................."""})
      : super(key: key);

  final String destination;
  final String description;
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> destinations = getContext("destinations");
    String title = destinations[destination][1];
    return Stack(children: [
      // TitleWidget(title: title),
      DescriptionWidget(title: title, description: description),
    ]);
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.04,
        left: ((36.6 - title.length) *
            (MediaQuery.of(context).size.width) *
            0.018 /
            5),
      ),
      child: Row(children: [
        Image.asset("assets/custom/img/1x/Recurso_295mdpi.png",
            width: MediaQuery.of(context).size.width * 0.05),
        SizedBox(
          width: title.length * MediaQuery.of(context).size.width * 0.01 +
              ((36.6 - title.length) *
                  (MediaQuery.of(context).size.width) *
                  0.018 /
                  10),
        ),
        Image.asset("assets/custom/img/1x/Recurso_294mdpi.png",
            width: MediaQuery.of(context).size.width * 0.05),
      ]),
    );
  }
}

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.02,
        left: MediaQuery.of(context).size.width * 0.03,
      ),
      child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                  color: const Color.fromARGB(255, 204, 164, 61),
                  fontSize: MediaQuery.of(context).size.width * 0.018,
                  fontWeight: FontWeight.bold,
                )),
              ),
              Text(
                description,
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                  color: const Color.fromARGB(255, 128, 128, 128),
                  fontSize: MediaQuery.of(context).size.width * 0.010,
                  fontWeight: FontWeight.bold,
                )),
              ),
            ],
          )),
    );
  }
}
