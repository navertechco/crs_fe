import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NetRates extends StatelessWidget {
  const NetRates({
    Key? key,
    required this.nrlist,
  }) : super(key: key);

  final List<TableRow> nrlist;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Table(
            columnWidths: {
              0: FixedColumnWidth(MediaQuery.of(context).size.width * 0.1),
              1: FixedColumnWidth(MediaQuery.of(context).size.width * 0.1),
              2: FixedColumnWidth(MediaQuery.of(context).size.width * 0.1),
              3: FixedColumnWidth(MediaQuery.of(context).size.width * 0.1),
            },
            border: TableBorder.all(),
            children: [
              TableRow(children: [
                Text("Room Type",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: MediaQuery.of(context).size.width * 0.012,
                      fontWeight: FontWeight.bold,
                    ))),
                Text("Quantity",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: MediaQuery.of(context).size.width * 0.012,
                      fontWeight: FontWeight.bold,
                    ))),
                Text("Passengers",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: MediaQuery.of(context).size.width * 0.012,
                      fontWeight: FontWeight.bold,
                    ))),
                Text("RoH p/P",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: MediaQuery.of(context).size.width * 0.012,
                      fontWeight: FontWeight.bold,
                    ))),
              ])
            ]),
        Table(columnWidths: {
          0: FixedColumnWidth(MediaQuery.of(context).size.width * 0.1),
          1: FixedColumnWidth(MediaQuery.of(context).size.width * 0.1),
          2: FixedColumnWidth(MediaQuery.of(context).size.width * 0.1),
          3: FixedColumnWidth(MediaQuery.of(context).size.width * 0.1),
        }, border: TableBorder.all(), children: nrlist),
      ],
    );
  }
}
