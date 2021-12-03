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
          child: Column(children: [
            Row(
              children: [
                const FormLabelWidget(
                    label: "Tour information   ", fontWeight: FontWeight.bold),
                SizedBox(width: MediaQuery.of(context).size.width * 0.01)
              ],
            ),
            CustomFormDropDownField(
              label: "Destination Country",
              data: [
                {"code": "1", "description": "hola"},
                {"code": "2", "description": "hola 2"},
              ],
            ),
            CustomFormDropDownField(
              label: "Purpose                        ",
              data: [
                {"code": "1", "description": "hola"},
                {"code": "2", "description": "hola 2"},
              ],
            ),
            CustomFormDropDownField(
              label: "Accomodation Type",
              data: [
                {"code": "1", "description": "hola"},
                {"code": "2", "description": "hola 2"},
              ],
            ),
            CustomFormDropDownField(
              label: "Destination                  ",
              data: [
                {"code": "1", "description": "hola"},
                {"code": "2", "description": "hola 2"},
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const FormLabelWidget(
                      label: "Date                                  ",
                      fontWeight: FontWeight.bold),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.01)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const FormLabelWidget(
                      label: "Arrival Date                 ",
                      fontWeight: FontWeight.normal),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                  RoundedFormDatepicker(format: DateFormat.yMEd()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const FormLabelWidget(
                      label: "Departure Date         ",
                      fontWeight: FontWeight.normal),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                  RoundedFormDatepicker(format: DateFormat.yMEd()),
                ],
              ),
            ),
            CustomFormDropDownField(
              label: "Passengers                 ",
              data: [
                {"code": "1", "description": "hola"},
                {"code": "2", "description": "hola 2"},
              ],
            ),
            Row(
              children: [
                const FormLabelWidget(
                    label: "Agent 1                           ",
                    fontWeight: FontWeight.normal),
                SizedBox(width: MediaQuery.of(context).size.width * 0.0001)
              ],
            ),
          ]),
        ),
        const Spacer(),
      ],
    );
  }
}

class CustomFormDropDownField extends StatelessWidget {
  const CustomFormDropDownField({
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
          FormLabelWidget(label: label, fontWeight: FontWeight.normal),
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

class FormLabelWidget extends StatelessWidget {
  const FormLabelWidget({
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
