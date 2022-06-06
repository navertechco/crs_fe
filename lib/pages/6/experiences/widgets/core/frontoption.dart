import 'package:flutter/material.dart';
import '../index.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:naver_crs/index.dart';

class ExperienceFrontOptionWidget extends StatelessWidget {
  const ExperienceFrontOptionWidget({Key? key, required this.experience})
      : super(key: key);
  final String experience;
  @override
  Widget build(BuildContext context) {
    List filteredByDestination = [];

    for (Map item in experiences) {
      List itemList = item.values.toList();
      CatalogDto exp = CatalogDto(itemList);
      if (exp.description.toString().toUpperCase() ==
          experience.toString().toUpperCase()) {
        filteredByDestination.add(exp);
      }
    }

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(
        experience.toString().split("-")[0],
        style: GoogleFonts.poppins(
            textStyle: TextStyle(
          color:
              getTrColor(getExperienceValueByName(experience)["travel_rhythm"]),
          fontSize: MediaQuery.of(context).size.width * 0.010,
          fontWeight: FontWeight.bold,
        )),
      ),
    );
  }
}
