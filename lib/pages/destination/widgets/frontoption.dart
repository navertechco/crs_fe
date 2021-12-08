import 'package:flutter/material.dart';

class FrontOptionWidget extends StatelessWidget {
  const FrontOptionWidget({Key? key, this.destination = "coast"})
      : super(key: key);

  final String destination;
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> destinations = {
      "northern": [
        "assets/custom/img/1x/Recurso 309mdpi.png",
        "assets/custom/img/1x/Recurso 308mdpi.png"
      ],
      "southern": [
        "assets/custom/img/1x/Recurso 300mdpi.png",
        "assets/custom/img/1x/Recurso 225mdpi.png"
      ],
      "galapagos": [
        "assets/custom/img/1x/Recurso 565mdpi.png",
        "assets/custom/img/1x/Recurso 564mdpi.png"
      ],
      "volcano": [
        "assets/custom/img/1x/Recurso 304mdpi.png",
        "assets/custom/img/1x/Recurso 303mdpi.png"
      ],
      "amazon": [
        "assets/custom/img/1x/Recurso 293mdpi.png",
        "assets/custom/img/1x/Recurso 292mdpi.png"
      ],
      "quito": [
        "assets/custom/img/1x/Recurso 216mdpi.png",
        "assets/custom/img/1x/Recurso 215mdpi.png"
      ],
      "guayaquil": [
        "assets/custom/img/1x/Recurso 214mdpi.png",
        "assets/custom/img/1x/Recurso 213mdpi.png"
      ],
      "cuenca": [
        "assets/custom/img/1x/Recurso 204mdpi.png",
        "assets/custom/img/1x/Recurso 203mdpi.png"
      ],
      "otavalo": [
        "assets/custom/img/1x/Recurso 202mdpi.png",
        "assets/custom/img/1x/Recurso 201mdpi.png"
      ],
      "coast": [
        "assets/custom/img/1x/Recurso 193mdpi.png",
        "assets/custom/img/1x/Recurso 192mdpi.png"
      ],
    };
    return Stack(children: [
      Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.01,
          left: MediaQuery.of(context).size.width * 0.01,
        ),
        child: Image.asset(destinations[destination][0],
            width: MediaQuery.of(context).size.width * 0.4),
      ),
      Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.04,
          left: MediaQuery.of(context).size.width * 0.005,
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Image.asset(destinations[destination][1]),
        ),
      ),
    ]);
  }
}
