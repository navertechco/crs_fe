import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';
import 'customdescription.dart';

class Cover extends StatelessWidget {
  const Cover({Key? key }) : super(key: key);
 

  @override
  Widget build(BuildContext context) {
    Map tour = globalctx.memory["tour"];
    Map customer = globalctx.memory["customer"];
    var title = tour["title"] ?? "Enchanting Ecuador";
    var passengers = tour["passengers"] ?? "1";
    var days = totalDays.value;
    var nights = days - 1;
    var valid = getValue(tour, "valid_until", def: "");
    var description = tour["description"] ??
        "We present below this proposal document of our excellent travel experience services, unique in Ecuador";

    return Column(
      children: [
        CustomDescriptionWidget(
            text: title,
            width: 0.25,
            fontSize: 0.020,
            fontWeight: FontWeight.bold),
        CustomDescriptionWidget(
            text: "${customer["lead_passenger"]} x $passengers",
            width: 0.18,
            fontSize: 0.018,
            fontWeight: FontWeight.bold),
        CustomDescriptionWidget(
            text: "$days Days / $nights Nights",
            width: 0.18,
            fontSize: 0.016,
            fontWeight: FontWeight.bold),
        CustomDescriptionWidget(
            text: description,
            width: 0.55,
            fontSize: 0.012,
            fontWeight: FontWeight.bold),
        CustomDescriptionWidget(
            text: "Valid until: $valid",
            width: 0.15,
            fontSize: 0.012,
            fontWeight: FontWeight.bold),
      ],
    );
  }
}
