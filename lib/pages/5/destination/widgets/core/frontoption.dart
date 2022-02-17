import 'package:flutter/material.dart';
import '../../../../index.dart';

class FrontOptionWidget extends StatelessWidget {
  const FrontOptionWidget({Key? key, this.destination = "coast"})
      : super(key: key);

  final String destination;
  @override
  Widget build(BuildContext context) {
    List destinationParam = getParam("DESTINATION_DATA").values.toList();
    CatalogDto destinationData = CatalogDto(destinationParam);
    Map<String, dynamic> destinations = destinationData.value;
    var airport = destinations[destination][6];
    var boat = destinations[destination][7];
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
    ]);
  }
}
