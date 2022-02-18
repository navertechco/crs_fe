import 'package:flutter/material.dart';
import '../../../../index.dart';

class FrontOptionWidget extends StatelessWidget {
  const FrontOptionWidget({Key? key, this.destination = "coast"})
      : super(key: key);

  final String destination;
  @override
  Widget build(BuildContext context) {
    var destinations = processCatalog("destinations");
    // List destinationParam = getParam("DESTINATION_DATA").values.toList();
    // CatalogDto destinationData = CatalogDto(destinationParam);
    // Map<String, dynamic> destinations = destinationData.value;
    var airport = false;
    var boat = false;
    var dest = destinations
        .firstWhere((e) => e["description"] == destination)["value"];
    if (dest != null) {
      airport = dest[6];
      boat = dest[7];
    }
    return Stack(children: [
      Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.01,
          left: MediaQuery.of(context).size.width * 0.01,
        ),
        child: Image.asset(dest[2],
            width: MediaQuery.of(context).size.width * 0.4),
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
    ]);
  }
}
