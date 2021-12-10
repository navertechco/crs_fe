import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/index.dart';

import '../index.dart';

/// hello
class ResumeWidget extends GetView<ResumeController> {
  const ResumeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(children: [
          const CustomFormTitleWidget(level: 1, label: "Client Information"),
          Row(
            children: const [
              CustomPadingTitleWidget(
                  customlabel: "Customer Type:", fontWeight: FontWeight.normal),
              Text("Legal"),
            ],
          ),
          Row(
            children: const [
              CustomPadingTitleWidget(
                  customlabel: "Legal Name:", fontWeight: FontWeight.normal),
              Text("British Bank"),
            ],
          ),
          Row(
            children: const [
              CustomPadingTitleWidget(
                  customlabel: "Contact Name:", fontWeight: FontWeight.normal),
              Text("Mr. Frank Windsor"),
            ],
          ),
          Row(
            children: const [
              CustomPadingTitleWidget(
                  customlabel: "Id Number:", fontWeight: FontWeight.normal),
              Text("    102525666"),
            ],
          ),
          Row(
            children: const [
              CustomPadingTitleWidget(
                  customlabel: "Birth date:", fontWeight: FontWeight.normal),
              Text("10-10-1950"),
            ],
          ),
          Row(
            children: const [
              CustomPadingTitleWidget(
                  customlabel: "Address:", fontWeight: FontWeight.normal),
              Text("400 Downie St and Inverness St, London, England"),
            ],
          ),
          Row(
            children: const [
              CustomPadingTitleWidget(
                  customlabel: "e-Mail:", fontWeight: FontWeight.normal),
              Text("frank.winsor@britishbank.com"),
            ],
          ),
          Row(
            children: const [
              CustomPadingTitleWidget(
                  customlabel: "Travel code:", fontWeight: FontWeight.normal),
              Text("15265112"),
            ],
          ),
          const CustomFormTitleWidget(level: 1, label: "Tour Information"),
          Row(
            children: const [
              CustomPadingTitleWidget(
                  customlabel: "Destination Country:",
                  fontWeight: FontWeight.normal),
              Text("Ecuador"),
            ],
          ),
          Row(
            children: const [
              CustomPadingTitleWidget(
                  customlabel: "Trip Purpose:", fontWeight: FontWeight.normal),
              Text("Adventure"),
            ],
          ),
          Row(
            children: const [
              CustomPadingTitleWidget(
                  customlabel: "Accomodation Type:",
                  fontWeight: FontWeight.normal),
              Text("5 Stars"),
            ],
          ),
          Row(
            children: const [
              CustomPadingTitleWidget(
                  customlabel: "Arrival Date:", fontWeight: FontWeight.normal),
              Text("09-01-22"),
            ],
          ),
          Row(
            children: const [
              CustomPadingTitleWidget(
                  customlabel: "Departure Date:",
                  fontWeight: FontWeight.normal),
              Text("14-01-22"),
            ],
          ),
          Row(
            children: const [
              CustomPadingTitleWidget(
                  customlabel: "Contact Agent:", fontWeight: FontWeight.normal),
              Text("Jose Cuevas"),
            ],
          ),
          Row(
            children: const [
              CustomPadingTitleWidget(
                  customlabel: "Arrival Port:", fontWeight: FontWeight.normal),
              Text("Quito"),
            ],
          ),
          Row(
            children: const [
              CustomPadingTitleWidget(
                  customlabel: "Departure Port:",
                  fontWeight: FontWeight.normal),
              Text("Guayaquil"),
            ],
          ),
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
