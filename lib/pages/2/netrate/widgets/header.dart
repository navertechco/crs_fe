import 'package:flutter/material.dart';
import '../../../index.dart';
import 'customformheader.dart';
import 'customformtitle.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    var customer = memory["customer"] ?? {};
    var tour = memory["tour"] ?? {};
    var logistic = memory["logistic"] ?? {};

    return Column(
      children: [
        const CustomFormTitleWidget(level: 1, label: "Client Information"),
        // CustomFormHeaderWidget(data: chunkMap(customer, 3, customerTemplate)),
        const CustomFormTitleWidget(level: 1, label: "Tour Information"),
        // CustomFormHeaderWidget(data: chunkMap(tour, 3, tourTemplate)),
        const CustomFormTitleWidget(level: 1, label: "Logistic Information"),
        // CustomFormHeaderWidget(data: chunkMap(logistic, 3, logisticTemplate)),
        CustomFormTitleWidget(
            level: 2,
            label:
                "Itinerary #(Between: ${currentDayFormat.format(arrivalDate.value)} and ${currentDayFormat.format(departureDate.value)})"),
      ],
    );
  }
}
