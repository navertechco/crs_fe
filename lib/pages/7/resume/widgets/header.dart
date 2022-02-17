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
    var memory = globalctx.memory.value;
    var customer = memory["customer"] ?? {};
    var tour = memory["tour"] ?? {};

    List<Map<String, dynamic>> customerTemplate = [
      {"code": "contact_name", "description": "contact_name", "value": "1"},
      {
        "code": "legal_client_type",
        "description": "legal_client_type",
        "value": "1"
      },
      {"code": "customer_type", "description": "customer_type", "value": "1"},
      {"code": "country", "description": "country", "value": "1"},
      {"code": "email", "description": "email", "value": "1"},
      {"code": "travel_code", "description": "travel_code", "value": "1"},
      {"code": "lead_passenger", "description": "lead_passenger", "value": "1"},
      {"code": "address_line", "description": "address_line", "value": "1"},
      {"code": "city", "description": "city", "value": "1"},
      {"code": "dni", "description": "dni", "value": "1"},
      {"code": "tax_id", "description": "tax_id", "value": "1"},
      {"code": "names", "description": "names", "value": "1"},
      {"code": "last_names", "description": "last_names", "value": "1"},
      {"code": "birth_date", "description": "birth_date", "value": "1"}
    ];

    List<Map<String, dynamic>> tourTemplate = [
      {"code": "country", "description": "country", "value": "1"},
      {
        "code": "accomodation_type",
        "description": "accomodation_type",
        "value": "1"
      },
      {"code": "purpose", "description": "purpose", "value": "1"},
      {"code": "passengers", "description": "passengers", "value": "1"},
      {"code": "arrival_date", "description": "arrival_date", "value": "1"},
      {"code": "departure_date", "description": "departure_date", "value": "1"}
    ];

    return Column(
      children: [
        const CustomFormTitleWidget(level: 1, label: "Client Information"),
        CustomFormHeaderWidget(data: chunkMap(customer, 3, customerTemplate)),
        const CustomFormTitleWidget(level: 1, label: "Tour Information"),
        CustomFormHeaderWidget(data: chunkMap(tour, 3, tourTemplate)),
        CustomFormTitleWidget(
            level: 2,
            label:
                "Itinerary #(Between: ${currentDayFormat.format(arrivalDate.value)} and ${currentDayFormat.format(departureDate.value)})"),
      ],
    );
  }
}
