import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    Map<String, dynamic> destinations = {
      "northern": [
        "assets/custom/img/1x/Recurso 318mdpi.png",
        "Northern Highlands"
      ],
      "southern": [
        "assets/custom/img/1x/Recurso 318mdpi.png",
        "Southern Highlands"
      ],
      "galapagos": ["assets/custom/img/1x/Recurso 318mdpi.png", "Galápagos"],
      "volcano": ["assets/custom/img/1x/Recurso 318mdpi.png", "Volcano "],
      "amazon": ["assets/custom/img/1x/Recurso 318mdpi.png", "Amazon "],
      "quito": ["assets/custom/img/1x/Recurso 318mdpi.png", "Quito"],
      "guayaquil": ["assets/custom/img/1x/Recurso 318mdpi.png", "Quayaquil"],
      "cuenca": ["assets/custom/img/1x/Recurso 318mdpi.png", "Cuenca"],
      "otavalo": ["assets/custom/img/1x/Recurso 318mdpi.png", "Otavalo"],
      "coast": ["assets/custom/img/1x/Recurso 318mdpi.png", "Coast"],
    };
    String title = destinations[destination][1];
    return Stack(children: [
      Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.0,
          left: MediaQuery.of(context).size.width * 0.0,
        ),
        child: Image.asset(destinations[destination][0],
            width: MediaQuery.of(context).size.width * 0.5),
      ),
      Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.02,
          left: MediaQuery.of(context).size.width * 0.005,
        ),
        child: Align(
            alignment: Alignment.bottomCenter,
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
      ),
      Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.04,
          left: ((36.6 - title.length) *
              (MediaQuery.of(context).size.width) *
              0.018 /
              4.8),
        ),
        child: Row(children: [
          Image.asset("assets/custom/img/1x/Recurso 295mdpi.png",
              width: MediaQuery.of(context).size.width * 0.05),
          SizedBox(
            width: title.length * MediaQuery.of(context).size.width * 0.01 +
                ((36.6 - title.length) *
                    (MediaQuery.of(context).size.width) *
                    0.018 /
                    20),
          ),
          Image.asset("assets/custom/img/1x/Recurso 294mdpi.png",
              width: MediaQuery.of(context).size.width * 0.05),
        ]),
      ),
    ]);
  }
}
