// ignore_for_file: unused_field, must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:naver_crs/common/index.dart';
import 'package:naver_crs/pages/tourparameters/state.dart';

class TourParametersForm extends StatefulWidget {
  TourParametersForm({
    Key? key,
    required this.formKey,
    required this.state,
    required this.profile,
  }) : super(key: key);

  final GlobalKey formKey;
  final bool profile;
  TourParametersState state;
  @override
  State<TourParametersForm> createState() => _TourParametersFormState();
}

class _TourParametersFormState extends State<TourParametersForm> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        const SizedBox(
          child: SingleChildScrollView(
            child: Text("Scroll"),
          ),
        ),
        const Spacer(),
        const Spacer(),
        const Spacer(),
        const Spacer(),
        SizedBox(
          child: Column(children: const [
            CustomTitleWidget(
              width: 0.3,
              fontWeight: FontWeight.bold,
              label: "Agent 1",
            ),
            CustomTitleWidget(
                width: 0.225,
                fontWeight: FontWeight.bold,
                label: "Tour information"),
            CustomFormDropDownFieldWidget(
              label: "Destination Country",
              data: [
                {"code": "1", "description": "Ecuador"},
                // {"code": "2", "description": "hola 2"},
              ],
            ),
            CustomFormDropDownFieldWidget(
              label: "Purpose                        ",
              data: [
                {"code": "1", "description": "AVENTURE"},
                {"code": "2", "description": "CULLINARY"},
              ],
            ),
            CustomFormDropDownFieldWidget(
              label: "Accomodation Type",
              data: [
                {"code": "1", "description": "5 STARS"},
                {"code": "2", "description": "4 STARS"},
              ],
            ),
            CustomFormDropDownFieldWidget(
              label: "Destination                  ",
              data: [
                {"code": "1", "description": "NORTH HIGHLANDS"},
                {"code": "2", "description": "SOUTH HIGHLANDS"},
                {"code": "3", "description": "COAST"},
                {"code": "4", "description": "GALAPAGOS"},
                {"code": "5", "description": "AMAZON"},
              ],
            ),
            CustomTitleWidget(
                width: 0.235,
                fontWeight: FontWeight.bold,
                label: "Date                              "),
            CustomFormDateFieldWidget(label: "Arrival Date                 "),
            CustomFormDateFieldWidget(label: "Departure Date         "),
            CustomFormDropDownFieldWidget(
              label: "Passengers                 ",
              data: [
                {"code": "1", "description": "1"},
                {"code": "2", "description": "2"},
                {"code": "3", "description": "3-5"},
                {"code": "4", "description": "6-10"},
                {"code": "5", "description": "11-20"},
                {"code": "6", "description": "21-30"},
              ],
            ),
            CustomKeypadWidget(),
          ]),
        ),
        const Spacer(),
      ],
    );
  }
}

class CustomKeypadWidget extends StatelessWidget {
  const CustomKeypadWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.11),
          Row(
            children: [
              GestureDetector(
                onTap: () {},
                child: const CustomFormLabelWidget(
                    label: "Previous", fontWeight: FontWeight.normal),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.225),
              GestureDetector(
                onTap: () {},
                child: const CustomFormLabelWidget(
                    label: "Next", fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomTitleWidget extends StatelessWidget {
  const CustomTitleWidget({
    Key? key,
    required this.label,
    this.fontWeight = FontWeight.normal,
    this.width = 0.225,
  }) : super(key: key);
  final String label;
  final FontWeight fontWeight;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomFormLabelWidget(label: label, fontWeight: fontWeight),
        SizedBox(width: MediaQuery.of(context).size.width * width)
      ],
    );
  }
}

class CustomFormDateFieldWidget extends StatelessWidget {
  const CustomFormDateFieldWidget({
    Key? key,
    required this.label,
  }) : super(key: key);
  final String label;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CustomFormLabelWidget(label: label, fontWeight: FontWeight.normal),
          SizedBox(width: MediaQuery.of(context).size.width * 0.01),
          RoundedFormDatepicker(format: DateFormat.yMEd()),
        ],
      ),
    );
  }
}

class CustomFormDropDownFieldWidget extends StatelessWidget {
  const CustomFormDropDownFieldWidget({
    Key? key,
    required this.label,
    required this.data,
  }) : super(key: key);

  final String label;
  final List<Map<String, dynamic>> data;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CustomFormLabelWidget(label: label, fontWeight: FontWeight.normal),
          SizedBox(width: MediaQuery.of(context).size.width * 0.01),
          RoundedFormDropdown(
            data: data,
            hintText: "",
            onSaved: (value) {},
          )
        ],
      ),
    );
  }
}

class CustomFormLabelWidget extends StatelessWidget {
  const CustomFormLabelWidget({
    Key? key,
    required this.label,
    required this.fontWeight,
  }) : super(key: key);
  final String label;
  final FontWeight fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
        color: const Color.fromRGBO(0, 0, 1, 0.5),
        fontSize: MediaQuery.of(context).size.width * 0.015,
        fontWeight: fontWeight,
      )),
    );
  }
}
