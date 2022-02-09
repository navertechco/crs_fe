
import 'package:flutter/material.dart';

import '../../../index.dart';
import 'customdescription.dart';

class Cover extends StatelessWidget {
  const Cover({Key? key, required this.data}) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    var memory = globalctx.memory.value;
    var tour = getValue(memory, "tour", def: {});
    var customer = getValue(memory, "customer", def: {});
    var title = getValue(tour, "title", def: "");
    var passengers = getValue(tour, "passengers", def: 1);
    var days = currentDay.value;
    var nights = days - 1;
    var valid = getValue(tour, "valid_until", def: "31-12-2022");
    var description = getValue(tour, "description", def: "");

    return Column(
      children: [
        CustomDescriptionWidget(
            text: title,
            width: 0.25,
            fontSize: 0.020,
            fontWeight: FontWeight.bold),
        CustomDescriptionWidget(
            text: "${customer["legal_name"]} x $passengers",
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

