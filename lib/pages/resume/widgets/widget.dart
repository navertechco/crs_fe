import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/index.dart';

import '../index.dart';

/// hello
class ResumeWidget extends GetView<ResumeController> {
  const ResumeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<List<Map<String, dynamic>>> clientdata = [
      [
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
      ],
      [
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
      ],
      [
        {
          "code": "passengers",
          "description": "Passengers Number",
          "value": "10"
        }
      ]
    ];
    List<List<Map<String, dynamic>>> tourdata = [
      [
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
      ],
      [
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
      ]
    ];
    return Center(
      child: SingleChildScrollView(
        child: Column(children: [
          const CustomFormTitleWidget(level: 1, label: "Client Information"),
          CustomFormHeaderWidget(data: clientdata),
          const CustomFormTitleWidget(level: 1, label: "Tour Information"),
          CustomFormHeaderWidget(data: tourdata),
          const CustomFormTitleWidget(level: 2, label: "Itinerary"),
          const CustomFormTitleWidget(
              level: 3, label: "Arrival#####Date: 09-01-22"),
          const CustomFormTitleWidget(
              level: 3,
              label:
                  "Star Destination:#Cuenca#(Between: 10-01-22 and 13-01-22)"),
          const CustomFormTitleWidget(
              level: 4, label: "Day: 1#####Date: 10-01-22"),
          const CustomFormTitleWidget(
              level: 4, label: "Day: 2#####Date: 11-01-22"),
          const CustomFormTitleWidget(
              level: 4, label: "Day: 3#####Date: 12-01-22"),
          const CustomFormTitleWidget(
              level: 4, label: "Day: 4#####Date: 13-01-22"),
        ]),
      ),
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
          title += titlearray[i] + ("\t" * 10);
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
