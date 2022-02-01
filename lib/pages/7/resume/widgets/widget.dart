// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../index.dart';
import '../index.dart';

/// hello
class ResumeWidget extends GetView<ResumeController> {
  const ResumeWidget({Key? key, required this.pkey}) : super(key: key);
  final pkey;
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = getContext("data");

    return Itinerary(
      pkey: pkey,
      data: data,
    );
  }
}

class Itinerary extends StatelessWidget {
  Itinerary({Key? key, required this.data, required this.pkey})
      : super(key: key);

  final Map<String, dynamic> data;
  final _controller = ScrollController();
  final pkey;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.4,
          bottom: MediaQuery.of(context).size.height * 0.4),
      child: Stack(
        children: [
          Positioned(
            left: 100,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 1.2,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Center(
                child: Scrollbar(
                  child: SingleChildScrollView(
                    controller: _controller,
                    child: Column(children: [
                      RepaintBoundary(
                          key: pkey["cover"], child: Cover(data: data)),
                      RepaintBoundary(
                        key: pkey["header"],
                        child: Header(
                          data: data,
                        ),
                      ),
                      Destinations(data: data),
                      if (pkey["end"] != null)
                        RepaintBoundary(
                          key: pkey["end"],
                          child: EndServices(data: data),
                        ),
                    ]),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EndServices extends StatelessWidget {
  const EndServices({Key? key, required this.data}) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    var detail = globalctx.memory.value;
    var end = getValue(detail, "end", def: []);
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
          Text("\$ ${roh}",
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
        const CustomDescriptionWidget(
            text:
                """
            B = Breakfast
            L= Lunch
            LB= Lunch Box
            D = Dinner
            O = Overnight
            """,
            width: 0.5,
            fontSize: 0.012,
            fontWeight: FontWeight.bold),
        const CustomDescriptionWidget(
            text: "Net Rate",
            width: 0.5,
            fontSize: 0.014,
            fontWeight: FontWeight.bold),
        NetRates(nrlist: nrlist),
        const CustomDescriptionWidget(
            text: "Included",
            width: 0.5,
            fontSize: 0.014,
            fontWeight: FontWeight.bold),
        Column(children: includedlist),
        const CustomDescriptionWidget(
            text: "Not Included",
            width: 0.5,
            fontSize: 0.014,
            fontWeight: FontWeight.bold),
        Column(children: notincludedlist)
      ],
    );
  }
}

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

class Cover extends StatelessWidget {
  const Cover({Key? key, required this.data}) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    var detail = globalctx.memory.value;
    var tour = getValue(detail, "tour", def: []);
    var customer = getValue(detail, "customer", def: []);
    var title = getValue(tour, "title", def: []);
    var passengers = getValue(tour, "passengers", def: []);
    var days = currentDay.value;
    var nights = days - 1;
    var valid = getValue(tour, "valid_until", def: []);
    var description = getValue(tour, "description", def: []);

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

class Destinations extends StatelessWidget {
  const Destinations({
    Key? key,
    required this.data,
  }) : super(key: key);

  final data;

  @override
  Widget build(BuildContext context) {
    List<Widget> destinations = [];
    var detsdata = getValue(data["detail"], "destinations", def: []);
    if (data != null) {
      for (var i = 0; i < detsdata.length; i++) {
        var key = GlobalKey();
        globalctx.keys["destination-$i"] = key;
        destinations.add(CustomFormDestination(data: data, index: i));
      }
    }
    return Column(
      children: destinations,
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    var customer = getValue(data["detail"], "customer", def: {});
    var tour = getValue(data["detail"], "tour", def: {});

    List<Map<String, dynamic>> customerTemplate = [
      {
        "code": "brith_date",
        "description": "Birth Date",
        "value": "10/10/1950"
      },
      {"code": "customer_id", "description": "Client code", "value": "1"},
      {
        "code": "contact_name",
        "description": "Contact Name",
        "value": "Mr. Frank Stevens"
      },
      {"code": "customer_type", "description": "Customer Type", "value": "1"},
      {
        "code": "email",
        "description": "e-Mail",
        "value": "frank.stevens@gmail.com"
      },
      {"code": "id_number", "description": "DNI", "value": "15261548"},
      {
        "code": "legal_name",
        "description": "Lagal Name",
        "value": "British Bank"
      },
    ];

    List<Map<String, dynamic>> tourTemplate = [
      {
        "code": "accomodation_type_id",
        "description": "Accomodation Type",
        "value": "1"
      },
      {"code": "passengers", "description": "Passengers", "value": "18"},
      {
        "code": "arrival_date",
        "description": "Arrival Date",
        "value": "09/10/2022"
      },
      {
        "code": "departure_date",
        "description": "Departure Date",
        "value": "14/10/2022"
      },
      {"code": "valid_until", "description": "TITLE", "value": "31/12/2022"},
      {"code": "contact_agent", "description": "Contact Agent", "value": "1"},
      {"code": "days", "description": "Days", "value": "10"},
      {
        "code": "destination_country_id",
        "description": "Destination Country",
        "value": "1"
      },
      {"code": "nights", "description": "Nigths", "value": "9"},
      {"code": "partner", "description": "Partner", "value": "CNH Tours"},
      {"code": "purpose_id", "description": "Purpose", "value": "1"},
      {"code": "rooms", "description": "Rooms", "value": "1s;16d;1t"},
    ];

    return Column(
      children: [
        const CustomFormTitleWidget(level: 1, label: "Client Information"),
        CustomFormHeaderWidget(data: chunkMap(customer, 3, customerTemplate)),
        const CustomFormTitleWidget(level: 1, label: "Tour Information"),
        CustomFormHeaderWidget(data: chunkMap(tour, 3, tourTemplate)),
        const CustomFormTitleWidget(level: 2, label: "Itinerary"),
      ],
    );
  }
}

class CustomFormDestination extends StatelessWidget {
  const CustomFormDestination({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);

  final Map<String, dynamic> data;
  final int index;
  @override
  Widget build(BuildContext context) {
    List<CustomFormDayWidget> daylist = [];
    var detail = globalctx.memory.value;
    var destinations = detail["destinations"];
    var destination = destinations[index];
    var days = destination["days"];
    for (int i = 0; i < days.length; i++) {
      var key = GlobalKey();
      globalctx.keys["day-$index-$i"] = key;
      daylist.add(CustomFormDayWidget(data: data, indexes: [index, i]));
    }
    return Column(
      children: [
        RepaintBoundary(
            key: globalctx.keys["destination-$index"],
            child: CustomFormTitleWidget(
                level: 3,
                label:
                    "Star Destination ${index + 1}:#Cuenca#(Between: 10-01-22 and 13-01-22)")),
        Column(
          children: daylist,
        ),
      ],
    );
  }
}

class CustomFormDayWidget extends StatelessWidget {
  const CustomFormDayWidget({
    Key? key,
    required this.data,
    required this.indexes,
  }) : super(key: key);

  final Map<String, dynamic> data;
  final List<int> indexes;
  @override
  Widget build(BuildContext context) {
    var destinationindex = indexes[0];
    var dayindex = indexes[1];
    var destinations;
    // ignore: unnecessary_null_comparison
    if (data != null) {
      destinations = data['destinations'];
    } else {
      destinations = [];
    }
    var destination = destinations.toList()[destinationindex].value;
    var day = destination['days'][dayindex];
    var daydate = day['date'];
    var meals = day['meals'];
    var observation = day['observation'];
    var parent = day['parent'];
    var daydescription = day['day_description'];
    return RepaintBoundary(
        key: globalctx.keys["day-$destinationindex-$dayindex"],
        child: Column(
          children: [
            CustomFormTitleWidget(
                level: 4, label: "Day: ${parent + 1}#####Date: $daydate"),
            CustomDescriptionWidget(
                text: daydescription, width: 0.55, fontSize: 0.016),
            CustomFormExperiencesDetailWidget(data: data, indexes: indexes),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            if (observation != null)
              CustomDescriptionWidget(
                text: "Observation: $observation",
                width: 0.55,
                fontSize: 0.016,
                fontWeight: FontWeight.bold,
              ),
            CustomDescriptionWidget(
                text: "Meals: $meals",
                width: 0.55,
                fontSize: 0.016,
                fontWeight: FontWeight.bold),
          ],
        ));
  }
}

class CustomDescriptionWidget extends StatelessWidget {
  const CustomDescriptionWidget({
    Key? key,
    this.text = "",
    this.width = 0.5,
    this.fontSize = 0.018,
    this.fontWeight = FontWeight.normal,
  }) : super(key: key);

  final text;
  final width;
  final fontSize;
  final fontWeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * width,
      child: RichText(
        softWrap: true,
        textAlign: TextAlign.justify,
        text: TextSpan(
            text: text,
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
              color: const Color.fromARGB(255, 0, 0, 0),
              fontSize: MediaQuery.of(context).size.width * fontSize,
              fontWeight: fontWeight,
            ))),
      ),
    );
  }
}

class CustomFormExperiencesDetailWidget extends StatelessWidget {
  const CustomFormExperiencesDetailWidget({
    Key? key,
    required this.data,
    required this.indexes,
  }) : super(key: key);
  final Map<String, dynamic> data;
  final List<int> indexes;
  @override
  Widget build(BuildContext context) {
    var destinationindex = indexes[0];
    var dayindex = indexes[1];

    List<CustomFormExperienceRowWidget> list = [];

    for (var i = 0;
        i <
            data["detail"]["destinations"][destinationindex]["days"][dayindex]
                    ['experiences']
                .length;
        i++) {
      list.add(CustomFormExperienceRowWidget(
          data: data, indexes: [destinationindex, dayindex, i]));
    }

    return Padding(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
      child: Column(
        children: list,
      ),
    );
  }
}

class CustomFormExperienceRowWidget extends StatelessWidget {
  const CustomFormExperienceRowWidget({
    Key? key,
    required this.data,
    required this.indexes,
  }) : super(key: key);
  final Map<String, dynamic> data;
  final List<int> indexes;
  @override
  Widget build(BuildContext context) {
    var destinationindex = indexes[0];
    var dayindex = indexes[1];
    var experienceindex = indexes[2];
    var day =
        data["detail"]['destinations'][destinationindex]['days'][dayindex];
    var experiences = day['experiences'];
    var experience = experiences[experienceindex];
    var nextexperience = experienceindex + 1 < experiences.length
        ? experiences[experienceindex + 1]
        : experience;
    var title = experience['title'].toString();
    var description = experience['description'].toString();
    var next = experience['next'].toString() != ""
        ? experience['next'].toString()
        : nextexperience['previous'].toString();

    return Column(
      children: [
        CustomDescriptionWidget(
          text: "$title ",
          width: 0.6,
          fontSize: 0.016,
          fontWeight: FontWeight.bold,
        ),
        Image.asset(
          "assets/custom/img/1x/Recurso_374mdpi.png",
        ),
        CustomDescriptionWidget(
          text: description,
          width: 0.6,
          fontSize: 0.016,
          fontWeight: FontWeight.normal,
        ),
        if (next != "null")
          CustomDescriptionWidget(
            text: "Next: $next",
            width: 0.6,
            fontSize: 0.016,
            fontWeight: FontWeight.bold,
          ),
      ],
    );
  }
}

class CustomFormHeaderWidget extends StatelessWidget {
  const CustomFormHeaderWidget({
    Key? key,
    required this.data,
  }) : super(key: key);
  final List<List<Map<String, dynamic>>> data;

  @override
  Widget build(BuildContext context) {
    List<CustomFormHeaderIterWidget> list = [];

    for (var i = 0; i < data.length; i++) {
      list.add(CustomFormHeaderIterWidget(data: data, index: i));
    }

    return Column(
      children: list,
    );
  }
}

class CustomFormHeaderIterWidget extends StatelessWidget {
  const CustomFormHeaderIterWidget({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);

  final List<List<Map<String, dynamic>>> data;
  final int index;
  @override
  Widget build(BuildContext context) {
    List<CustomFormHeaderRowWidget> list = [];

    for (var i = 0; i < data[index].length; i++) {
      list.add(CustomFormHeaderRowWidget(
        customlabel: data[index][i]["description"] + ":",
        value: data[index][i]["value"],
      ));
    }
    return Row(
      children: [
        SizedBox(width: MediaQuery.of(context).size.width * 0.083),
        Row(
          children: list,
        ),
      ],
    );
  }
}

class CustomFormHeaderRowWidget extends StatelessWidget {
  const CustomFormHeaderRowWidget({
    Key? key,
    required this.customlabel,
    required this.value,
  }) : super(key: key);
  final String customlabel;
  final String? value;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomPadingTitleWidget(
            width: 0.02,
            customlabel: customlabel,
            fontWeight: FontWeight.normal),
        Text(value!),
      ],
    );
  }
}

class CustomFormTitleWidget extends StatelessWidget {
  const CustomFormTitleWidget({
    Key? key,
    this.label = "",
    this.level = 1,
  }) : super(key: key);
  final String label;
  final int level;

  @override
  Widget build(BuildContext context) {
    var columnlabel = (() {
      var title = "";

      var titlearray = label.split("#");
      if (titlearray.length > 1) {
        for (var i = 0; i < titlearray.length; i++) {
          title += titlearray[i] + ("\t" * 7);
        }
        return title;
      }
      title = label;
      return title;
    })();

    var identlabel = (() {
      var ident = "";
      if (level > 1) {
        for (var i = 1; i <= level; i++) {
          ident += "\t";
        }
      }
      return ident;
    })();

    var customlabel = identlabel + columnlabel;

    return Column(
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: const Divider(color: Color.fromARGB(255, 0, 0, 0))),
        CustomPadingTitleWidget(
            customlabel: customlabel, fontWeight: FontWeight.bold),
        // SizedBox(
        //     width: MediaQuery.of(context).size.width * 0.7,
        //     child: const Divider(color: Color.fromARGB(255, 0, 0, 0))),
      ],
    );
  }
}

class CustomPadingTitleWidget extends StatelessWidget {
  const CustomPadingTitleWidget(
      {Key? key,
      required this.customlabel,
      this.fontWeight = FontWeight.bold,
      this.width = 0.1})
      : super(key: key);

  final String customlabel;
  final FontWeight fontWeight;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * width),
      child: CustomTitleWidget(
        width: width,
        fontWeight: fontWeight,
        label: customlabel,
      ),
    );
  }
}
