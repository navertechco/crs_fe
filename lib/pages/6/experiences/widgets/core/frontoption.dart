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
 

    return Stack(
      children: [
        Container(
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  experience.toString().replaceAll("-", " "),
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                    color: const Color.fromARGB(255, 204, 164, 61),
                    fontSize: MediaQuery.of(context).size.width * 0.010,
                    fontWeight: FontWeight.bold,
                  )),
                ),
              ),
            ),
            width: MediaQuery.of(context).size.width * 0.271,
            height: MediaQuery.of(context).size.height * 0.11,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: Image.asset(
                // row.value["experience_image"],
                "assets/custom/img/1x/Recurso_211mdpi.png",
                fit: BoxFit.cover,
              ).image,
            ))),
      ],
    );
  }
}
