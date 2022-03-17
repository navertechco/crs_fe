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
            width: MediaQuery.of(context).size.width * 0.39),
      ),
      Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.04,
          left: MediaQuery.of(context).size.width * 0.01,
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Image.asset(dest[3],
              width: MediaQuery.of(context).size.width * 0.2),
        ),
      ),
      Row(
        children: [
          if (type == "arrival")
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.025,
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
                      color: Colors.blue,
                      width: MediaQuery.of(context).size.width * 0.05),
                ],
              ),
            ),
          if (type == "departure")
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.025,
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
                      color: Colors.red,
                      width: MediaQuery.of(context).size.width * 0.05),
                ],
              ),
            ),
          // if (boat)
          //   Padding(
          //     padding: EdgeInsets.only(
          //       top: MediaQuery.of(context).size.height * 0.01,
          //       left: MediaQuery.of(context).size.width * 0.33,
          //     ),
          //     child: Image.asset("assets/custom/img/boat.png",
          //         color: Colors.blue,
          //         width: MediaQuery.of(context).size.width * 0.05),
          //   ),
          // if (type == "tour")
          //   Padding(
          //     padding: EdgeInsets.only(
          //       top: MediaQuery.of(context).size.height * 0.01,
          //       left: MediaQuery.of(context).size.width * 0.33,
          //     ),
          //     child: Image.asset("assets/custom/img/car.png",
          //         color: Colors.green,
          //         width: MediaQuery.of(context).size.width * 0.05),
          //   ),
        ],
      ),
      Obx(() {
        if (!validateDestinationDialog(destination, type).value) {
          return Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.017,
              left: MediaQuery.of(context).size.width * 0.013,
            ),
            child: Image.asset(dest[2],
                color: Color.fromARGB(100, 10, 10, 10),
                width: MediaQuery.of(context).size.width * 0.39),
          );
        } else {
          return Text("");
        }
      }),
    ]);
  }
}
