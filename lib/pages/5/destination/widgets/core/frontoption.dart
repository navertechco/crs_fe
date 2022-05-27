import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../index.dart';

class DestinationFrontOptionWidget extends StatelessWidget {
  const DestinationFrontOptionWidget(
      {Key? key,
      this.destination = "coast",
      required this.index,
      required this.type})
      : super(key: key);

  final String destination;
  final index;
  final type;
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison

    var dest = getDestinationValueByName(destination);

    return Stack(children: [
      Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.017,
          left: MediaQuery.of(context).size.width * 0.013,
        ),
        child: Image.asset(dest[2],
            width: MediaQuery.of(context).size.width * 0.39,
            height: MediaQuery.of(context).size.height * 0.13),
      ),
      Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.04,
          left: MediaQuery.of(context).size.width * 0.01,
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Image.asset(dest[3],
              width: MediaQuery.of(context).size.width * 0.39,
              height: MediaQuery.of(context).size.height * 0.13),
        ),
      ),
      Row(
        children: [
          if (type == "arrival")
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.000,
                left: MediaQuery.of(context).size.width * 0.05,
              ),
              child: Row(
                children: [
                  Text("Arrival",
                      style: KTextSytle(
                              context: context,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)
                          .getStyle()),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.25),
                  Image.asset("assets/custom/img/arrival.png",
                      color: Colors.yellowAccent,
                      width: MediaQuery.of(context).size.width * 0.05,
                      height: MediaQuery.of(context).size.height * 0.1),
                ],
              ),
            ),
          if (type == "departure")
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.0,
                left: MediaQuery.of(context).size.width * 0.05,
              ),
              child: Row(
                children: [
                  Text("Departure",
                      style: KTextSytle(
                              context: context,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)
                          .getStyle()),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.22),
                  Image.asset("assets/custom/img/departure.png",
                      color: Colors.redAccent,
                      width: MediaQuery.of(context).size.width * 0.05,
                      height: MediaQuery.of(context).size.height * 0.1),
                ],
              ),
            ),
        ],
      ),
      Obx(() {
        if (!validateDestinationDialog(destination, index, type).value) {
          return Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.017,
              left: MediaQuery.of(context).size.width * 0.013,
            ),
            child: Image.asset(dest[2],
                color: Color.fromARGB(100, 10, 10, 10),
                width: MediaQuery.of(context).size.width * 0.39,
                height: MediaQuery.of(context).size.height * 0.13),
          );
        } else {
          return Text("");
        }
      }),
    ]);
  }
}
