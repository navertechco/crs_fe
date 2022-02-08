import 'package:flutter/material.dart';
import '../../../../index.dart';

class FrontOptionWidget extends StatelessWidget {
  const FrontOptionWidget({Key? key, this.destination = "coast"})
      : super(key: key);

  final String destination;
  @override
  Widget build(BuildContext context) {
    var destinationData = getParam("DESTINATION_DATA");
    Map<dynamic, dynamic> destinations = getValue(destinationData, "value");
    var airport = destinations[destination][6];
    return Stack(children: [
      Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.01,
          left: MediaQuery.of(context).size.width * 0.01,
        ),
        child: Image.asset(destinations[destination][2],
            width: MediaQuery.of(context).size.width * 0.4),
      ),
      Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.04,
          left: MediaQuery.of(context).size.width * 0.01,
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Image.asset(destinations[destination][3],
              width: MediaQuery.of(context).size.width * 0.2),
        ),
      ),
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
    ]);
  }
}
