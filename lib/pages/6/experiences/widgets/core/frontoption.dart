import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../index.dart';

class FrontOptionWidget extends StatelessWidget {
  const FrontOptionWidget({Key? key, required this.experience})
      : super(key: key);
  final String experience;
  @override
  Widget build(BuildContext context) {
    var experiences = processCatalog("experiences");
    List filteredByDestination = [];

    for (Map item in experiences) {
      List itemList = item.values.toList();
      CatalogDto exp = CatalogDto(itemList);
      if (exp.description.toString().toUpperCase() ==
          experience.toString().toUpperCase()) {
        filteredByDestination.add(exp);
      }
    }

    var row = filteredByDestination[0];

    return Stack(
      children: [
        Container(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                experience,
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontSize: MediaQuery.of(context).size.width * 0.018,
                  fontWeight: FontWeight.bold,
                )),
              ),
            ),
            width: MediaQuery.of(context).size.width * 0.271,
            height: MediaQuery.of(context).size.height * 0.11,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: Image.asset(
                row.value["image"],
                fit: BoxFit.cover,
              ).image,
            ))),
      ],
    );
  }
}
