// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naver_crs/common/index.dart';

import '../index.dart';

/// hello
class ResumeWidget extends GetView<ResumeController> {
  const ResumeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Function chunkArray = (list, int portion) {
      List<List<Map<String, dynamic>>> chunks = [];
      int aprox = (list.length / portion).round() * portion;
      int module = aprox > list.length
          ? (list.length / portion).round()
          : (list.length / portion).round() + 1;

      for (var i = 0; i < module; i++) {
        chunks.add([]);
        for (var j = 0; j < portion; j++) {
          var index = (i * portion) + j;
          if (index > list.length - 1) {
            break;
          }
          chunks[i].add(list[index]);
        }
      }
      return chunks;
    };

    Map<String, dynamic> data = {
      "client": [
        {
          "code": "customer_type",
          "description": "Customer Type",
          "value": "Legal"
        },
        {
          "code": "legal_name",
          "description": "Legal Name",
          "value": "British Bank"
        },
        {
          "code": "contact_name",
          "description": "Contact Name",
          "value": "Mr. Frank Stevens"
        },
        {
          "code": "id_number",
          "description": "Identification Number",
          "value": "15261548"
        },
        {
          "code": "brith_date",
          "description": "Birth Date",
          "value": "10/10/1950"
        },
        {
          "code": "email",
          "description": "e-Mail",
          "value": "frank.stevens@gmail.com"
        },
        {
          "code": "passengers",
          "description": "Passengers Number",
          "value": "10"
        }
      ],
      "tour": [
        {
          "code": "destination_country",
          "description": "Destination Country",
          "value": "Ecuador"
        },
        {
          "code": "purpouse",
          "description": "Trip Purpose",
          "value": "ADVENTURE"
        },
        {
          "code": "accomodation_type",
          "description": "Accomodation Type",
          "value": "5 STARS"
        },
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
        {
          "code": "contact_agent",
          "description": "Contact Agent",
          "value": "Jose Cuevas"
        },
      ],
      "arrival": {"port": "Quito", "date": "09-01-2022"},
      "departure": {"port": "Guayaquil", "date": "14-01-2022"},
      "destinations": [
        {
          "destination_name": "cuenca",
          "destination_description": "Cuenca",
          "days": [
            {
              "description": "lorem ipsum dolor sit amet, consectetur",
              "date": "10-01-2022",
              "experiences": [
                {
                  "code": "Visit to plaza",
                  "description": "this visit is the most......",
                },
                {
                  "code": "Visit to Restaruant",
                  "description": "this visit is the most......",
                },
              ]
            },
            {
              "description": "lorem ipsum dolor sit amet, consectetur",
              "date": "11-01-2022",
              "experiences": [
                {
                  "code": "Visit to Museum",
                  "description": "lorem ipsum dolor sit amet, consectetur",
                },
              ]
            },
            {
              "description": "lorem ipsum dolor sit amet, consectetur",
              "date": "12-01-2022",
              "experiences": [
                {
                  "code": "Visit to disco",
                  "description": "lorem ipsum dolor sit amet, consectetur",
                },
                {
                  "code": "Visit to Restaurant",
                  "description": "lorem ipsum dolor sit amet, consectetur",
                },
              ]
            },
            {
              "description": "lorem ipsum dolor sit amet, consectetur",
              "date": "13-01-2022",
              "experiences": [
                {
                  "code": "accomodation_type",
                  "description": "Accomodation Type",
                },
              ]
            }
          ]
        }
      ]
    };

    List<CustomFormDayWidget> daylist = [];

    for (int i = 0; i < data["destinations"][0].length; i++) {
      daylist.add(CustomFormDayWidget(data: data, indexes: [0, i]));
    }

    return Center(
      child: SingleChildScrollView(
        child: Column(children: [
          const CustomFormTitleWidget(level: 1, label: "Client Information"),
          CustomFormHeaderWidget(data: chunkArray(data["client"], 3)),
          const CustomFormTitleWidget(level: 1, label: "Tour Information"),
          CustomFormHeaderWidget(data: chunkArray(data["tour"], 3)),
          const CustomFormTitleWidget(level: 2, label: "Itinerary"),
          CustomFormTitleWidget(
              level: 3,
              label:
                  "Arrival: ${data['arrival']['port'].toString()} #####Date: " +
                      data['arrival']['port'].toString()),
          const CustomFormTitleWidget(
              level: 3,
              label:
                  "Star Destination 1:#Cuenca#(Between: 10-01-22 and 13-01-22)"),
          Column(
            children: daylist,
          ),
          CustomFormTitleWidget(
              level: 3,
              label:
                  "Departure: ${data['departure']['port'].toString()} ####Date:" +
                      data['departure']['date'].toString()),
        ]),
      ),
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
    var destinations = data['destinations'];
    var destination = destinations[destinationindex];
    var day = destination['days'][dayindex];
    var daydate = day['date'];
    var daydescription = day['description'];
    return Column(
      children: [
        CustomFormTitleWidget(
            level: 4, label: "Day: ${dayindex + 1}#####Date: $daydate"),
        Text(daydescription,
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
              color: const Color.fromARGB(255, 0, 0, 0),
              fontSize: MediaQuery.of(context).size.width * 0.012,
              fontWeight: FontWeight.normal,
            ))),
        CustomFormActivitiesDetailWidget(data: data, indexes: indexes),
      ],
    );
  }
}

class CustomFormActivitiesDetailWidget extends StatelessWidget {
  const CustomFormActivitiesDetailWidget({
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

    List<CustomFormActivityRowWidget> list = [];

    for (var i = 0;
        i <
            data["destinations"][destinationindex]["days"][dayindex]
                    ['experiences']
                .length;
        i++) {
      list.add(CustomFormActivityRowWidget(
          data: data, indexes: [destinationindex, dayindex, i]));
    }

    return Padding(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.23),
      child: Column(
        children: list,
      ),
    );
  }
}

class CustomFormActivityRowWidget extends StatelessWidget {
  const CustomFormActivityRowWidget({
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
    var day = data['destinations'][destinationindex]['days'][dayindex];
    var experience = day['experiences'][experienceindex];
    var code = experience['code'].toString();
    var description = experience['description'].toString();
    return Row(
      children: [
        Text("${experienceindex + 1}.-$code: ",
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
              color: const Color.fromARGB(255, 0, 0, 0),
              fontSize: MediaQuery.of(context).size.width * 0.014,
              fontWeight: FontWeight.bold,
            ))),
        Text(description,
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
              color: const Color.fromARGB(255, 0, 0, 0),
              fontSize: MediaQuery.of(context).size.width * 0.012,
              fontWeight: FontWeight.normal,
            ))),
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
        SizedBox(width: MediaQuery.of(context).size.width * 0.18),
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
  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomPadingTitleWidget(
            width: 0.02,
            customlabel: customlabel,
            fontWeight: FontWeight.normal),
        Text(value),
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
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: const Divider(color: Color.fromARGB(255, 0, 0, 0))),
      ],
    );
  }
}

class CustomPadingTitleWidget extends StatelessWidget {
  const CustomPadingTitleWidget(
      {Key? key,
      required this.customlabel,
      this.fontWeight = FontWeight.bold,
      this.width = 0.2})
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
