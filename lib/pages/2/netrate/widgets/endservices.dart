import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naver_crs/index.dart';
import 'customdescription.dart';

class PrintDocs extends StatelessWidget {
  const PrintDocs({Key? key, required this.data}) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    var end = getValue(memory, "end", def: []);
    var netrates = getValue(end, "net_rates", def: []);
    var included = getValue(end, "included", def: []);
    var notincluded = getValue(end, "not_included", def: []);

    List<CustomDescriptionWidget> includedlist = [];
    List<CustomDescriptionWidget> notincludedlist = [];
    List<TableRow> nrlist = [];
    // ignore: unnecessary_null_comparison
    if (data != null && included != null) {
      for (var i = 0; i < included.length; i++) {
        includedlist.add(CustomDescriptionWidget(
            text: "\u2022 ${included[i]}",
            width: 0.45,
            fontSize: 0.012,
            fontWeight: FontWeight.bold));
      }
    }
    if (data != null && notincluded != null) {
      for (var i = 0; i < notincluded.length; i++) {
        notincludedlist.add(CustomDescriptionWidget(
            text: "\u2022 ${notincluded[i]}",
            width: 0.45,
            fontSize: 0.012,
            fontWeight: FontWeight.bold));
      }
    }

    if (data != null && netrates != null) {
      for (var i = 0; i < netrates.length; i++) {
        var row = netrates[i];
        var roomtype = row["room_type"];
        var quantity = row["quantity"];
        var passengers = row["passengers"];
        var roh = row["roh"];
        nrlist.add(TableRow(children: [
          Text(roomtype,
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                color: const Color.fromARGB(255, 0, 0, 0),
                fontSize: MediaQuery.of(context).size.width * 0.012,
                fontWeight: FontWeight.bold,
              ))),
          Text(quantity,
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                color: const Color.fromARGB(255, 0, 0, 0),
                fontSize: MediaQuery.of(context).size.width * 0.012,
                fontWeight: FontWeight.bold,
              ))),
          Text(passengers,
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                color: const Color.fromARGB(255, 0, 0, 0),
                fontSize: MediaQuery.of(context).size.width * 0.012,
                fontWeight: FontWeight.bold,
              ))),
          Text("\$ $roh",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                color: const Color.fromARGB(255, 0, 0, 0),
                fontSize: MediaQuery.of(context).size.width * 0.012,
                fontWeight: FontWeight.bold,
              ))),
        ]));
      }
    }
    return Column(
      children: [
        const CustomDescriptionWidget(
            text: "End Services",
            width: 0.15,
            fontSize: 0.016,
            fontWeight: FontWeight.bold),
        const CustomDescriptionWidget(
            text: "Meals",
            width: 0.5,
            fontSize: 0.014,
            fontWeight: FontWeight.bold),
        const CustomDescriptionWidget(text: """
            B = Breakfast
            L= Lunch
            LB= Lunch Box
            D = Dinner
            O = Overnight
            """, width: 0.5, fontSize: 0.012, fontWeight: FontWeight.bold),
      ],
    );
  }
}
