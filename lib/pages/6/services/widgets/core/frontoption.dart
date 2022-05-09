import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../index.dart';

class ServiceFrontOptionWidget extends StatelessWidget {
  const ServiceFrontOptionWidget({Key? key, required this.service})
      : super(key: key);
  final String service;
  @override
  Widget build(BuildContext context) {
    List filteredByDestination = [];

    for (Map item in findCatalog("services").toList()) {
      List itemList = item.values.toList();
      CatalogDto srv = CatalogDto(itemList);
      if (srv.description.toString().toUpperCase() ==
          service.toString().toUpperCase()) {
        filteredByDestination.add(srv);
      }
    }

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(
        service.toString().split("-")[0],
        style: GoogleFonts.poppins(
            textStyle: TextStyle(
          color: Color.fromARGB(255, 128, 128, 128),
          fontSize: MediaQuery.of(context).size.width * 0.010,
          fontWeight: FontWeight.bold,
        )),
      ),
    );
  }
}
