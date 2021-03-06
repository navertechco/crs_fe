import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/index.dart';

class DestinationFrontOptionWidget extends StatelessWidget {
  const DestinationFrontOptionWidget(
      {Key? key,
      this.destination = "coast",
      required this.index,
      required this.type,
      this.isListed = false})
      : super(key: key);

  final String destination;
  final index;
  final type;
  final isListed;
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison

    var dest = getDestinationValueByName(destination);

    return Stack(children: [
      Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.0074,
          left: MediaQuery.of(context).size.width * 0.005,
        ),
        child: Image.asset("assets/images/" + dest[2],
            width: MediaQuery.of(context).size.width * 0.39,
            height: MediaQuery.of(context).size.height * 0.13),
      ),
      Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.025,
          left: MediaQuery.of(context).size.width * 0.02,
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Image.asset("assets/images/" + dest[3],
              width: MediaQuery.of(context).size.width * 0.37,
              height: MediaQuery.of(context).size.height * 0.13),
        ),
      ),
      Row(
        children: [
          if (type == "arrival")
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.000,
                left: MediaQuery.of(context).size.width * 0.03,
              ),
              child: Row(
                children: [
                  Text("Arrival",
                      style: KTextSytle(
                              context: context,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)
                          .getStyle()),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.25),
                  Image.asset("assets/images/1x/arrival.png",
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
                left: MediaQuery.of(context).size.width * 0.03,
              ),
              child: Row(
                children: [
                  Text("Departure",
                      style: KTextSytle(
                              context: context,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)
                          .getStyle()),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.22),
                  Image.asset("assets/images/1x/departure.png",
                      color: Colors.redAccent,
                      width: MediaQuery.of(context).size.width * 0.05,
                      height: MediaQuery.of(context).size.height * 0.1),
                ],
              ),
            ),
        ],
      ),
      Obx(() {
        var t = arrivalDate.value;
        if (isListed ||
            !validateDragDestinationOptions(destination, index, type).value) {
          return Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.009,
              left: MediaQuery.of(context).size.width * 0.005,
            ),
            child: Image.asset("assets/images/" + dest[2],
                color: Color.fromARGB(100, 10, 10, 10),
                width: MediaQuery.of(context).size.width * 0.39,
                height: MediaQuery.of(context).size.height * 0.13),
          );
        } else {
          return Text('');
        }
      }),
    ]);
  }
}
