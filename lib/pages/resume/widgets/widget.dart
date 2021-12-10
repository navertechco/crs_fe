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
    Map<String, dynamic> data = getContext("data");

    return Itinerary(
      data: data,
    );
  }
}

class Itinerary extends StatelessWidget {
  Itinerary({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map<String, dynamic> data;
  final _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    List<CustomFormDestination> destinations = [];

    for (var i = 0; i < data["destinations"].length; i++) {
      destinations.add(CustomFormDestination(data: data, index: i));
    }
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.4,
          bottom: MediaQuery.of(context).size.height * 0.4),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 2,
        width: MediaQuery.of(context).size.width * 0.5,
        child: Center(
          child: Scrollbar(
            child: SingleChildScrollView(
              controller: _controller,
              child: Column(children: [
                Header(
                  data: data,
                ),
                Destinations(destinations: destinations),
                Departure(data: data),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class Departure extends StatelessWidget {
  const Departure({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    var departureport = data['departure']['port'].toString();
    var departuredate = data['departure']['date'].toString();
    return CustomFormTitleWidget(
        level: 3, label: "Departure: $departureport ####Date:" + departuredate);
  }
}

class Destinations extends StatelessWidget {
  const Destinations({
    Key? key,
    required this.destinations,
  }) : super(key: key);

  final List<CustomFormDestination> destinations;

  @override
  Widget build(BuildContext context) {
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
    var arrivalport = data['arrival']['port'].toString();
    var arrivaldate = data['arrival']['date'].toString();
    return Column(
      children: [
        const CustomFormTitleWidget(level: 1, label: "Client Information"),
        CustomFormHeaderWidget(data: chunkArray(data["client"], 3)),
        const CustomFormTitleWidget(level: 1, label: "Tour Information"),
        CustomFormHeaderWidget(data: chunkArray(data["tour"], 3)),
        const CustomFormTitleWidget(level: 2, label: "Itinerary"),
        CustomFormTitleWidget(
            level: 3, label: "Arrival: $arrivalport #####Date: " + arrivaldate),
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
    var destinations = data["destinations"];
    var destination = destinations[index];
    var days = destination["days"];
    for (int i = 0; i < days.length; i++) {
      daylist.add(CustomFormDayWidget(data: data, indexes: [index, i]));
    }
    return Column(
      children: [
        CustomFormTitleWidget(
            level: 3,
            label:
                "Star Destination ${index + 1}:#Cuenca#(Between: 10-01-22 and 13-01-22)"),
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
        CustomFormExpereincesDetailWidget(data: data, indexes: indexes),
      ],
    );
  }
}

class CustomFormExpereincesDetailWidget extends StatelessWidget {
  const CustomFormExpereincesDetailWidget({
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
            data["destinations"][destinationindex]["days"][dayindex]
                    ['experiences']
                .length;
        i++) {
      list.add(CustomFormExperienceRowWidget(
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
