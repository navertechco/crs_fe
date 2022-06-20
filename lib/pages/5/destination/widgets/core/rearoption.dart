import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naver_crs/pages/5/destination/widgets/destinationdetail/widgets/index.dart';

// ignore: must_be_immutable
class DestinationRearOptionWidget extends StatelessWidget {
  DestinationRearOptionWidget(
      {Key? key,
      this.destination = "coast",
      this.description =
          """Lorem Ipsum is simply dummy text of the printing and typesetting 
industry. Lorem Ipsum has been but also the leap into electronic 
typesetting, Lorem Ipsum has been but also................."""})
      : super(key: key);

  final String destination;
  String description;
  @override
  Widget build(BuildContext context) {
    var value = getDestinationValueByName(destination);
    var title = value[1];
    description = value[8];
    // title = value["title"];
    return Stack(children: [
      // TitleWidget(title: title),
      DescriptionWidget(title: title, description: description),
    ]);
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.04,
        left: ((36.6 - title.length) *
            (MediaQuery.of(context).size.width) *
            0.018 /
            5),
      ),
      child: Row(children: [
        Image.asset("assets/images/1x/Recurso_295mdpi.png",
            width: MediaQuery.of(context).size.width * 0.05),
        SizedBox(
          width: title.length * MediaQuery.of(context).size.width * 0.01 +
              ((36.6 - title.length) *
                  (MediaQuery.of(context).size.width) *
                  0.018 /
                  10),
        ),
        Image.asset("assets/images/1x/Recurso_294mdpi.png",
            width: MediaQuery.of(context).size.width * 0.05),
      ]),
    );
  }
}

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.02,
        left: MediaQuery.of(context).size.width * 0.03,
      ),
      child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                  color: const Color.fromARGB(255, 204, 164, 61),
                  fontSize: MediaQuery.of(context).size.width * 0.018,
                  fontWeight: FontWeight.bold,
                )),
              ),
              GestureDetector(
                onTap: () {
                  showCustomDialog(
                    context,
                    LeftWidget(destination: "quito", index: 0),
                    "Close",
                    buttonColor: Colors.white,
                  );
                },
                child: Text(
                  description,
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                    color: const Color.fromARGB(255, 128, 128, 128),
                    fontSize: MediaQuery.of(context).size.width * 0.010,
                    fontWeight: FontWeight.bold,
                  )),
                ),
              ),
            ],
          )),
    );
  }
}
