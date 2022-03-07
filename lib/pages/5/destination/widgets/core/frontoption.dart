import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../index.dart';

class FrontOptionWidget extends StatelessWidget {
  const FrontOptionWidget({Key? key, this.destination = "coast"})
      : super(key: key);

  final String destination;
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison

    try {
      var airport = false;
      var boat = false;
      var dest = getDestinationValue(destination);
      RxString state = getDestinationState(destination).toString().obs;

      if (dest != null) {
        airport = dest[6];
        boat = dest[7];
      }

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
            if (airport)
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01,
                  left: MediaQuery.of(context).size.width * 0.33,
                ),
                child: Image.asset("assets/custom/img/icon-plain.png",
                    color: Colors.red,
                    width: MediaQuery.of(context).size.width * 0.05),
              ),
            if (boat)
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01,
                  left: MediaQuery.of(context).size.width * 0.33,
                ),
                child: Image.asset("assets/custom/img/boat.png",
                    color: Colors.blue,
                    width: MediaQuery.of(context).size.width * 0.05),
              ),
            if (!boat & !airport)
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01,
                  left: MediaQuery.of(context).size.width * 0.33,
                ),
                child: Image.asset("assets/custom/img/car.png",
                    color: Colors.green,
                    width: MediaQuery.of(context).size.width * 0.05),
              ),
          ],
        ),
        Obx(() {
          if (draggable.value == 0 && state.value == "suggested") {
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
    } catch (e) {
      print(e);
    }

    return Text("");
  }
}
