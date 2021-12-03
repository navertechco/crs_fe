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
    return Align(
      alignment: Alignment.topCenter,
      child: Row(
        children: [
          const Spacer(),
          const SizedBox(
            child: SingleChildScrollView(
              child: Text("Scroll"),
            ),
          ),
          const Spacer(),
          const Spacer(),
          SizedBox(
            child: Column(children: [
              Row(
                children: [
                  const FormLabelWidget(
                      label: "Tour information   ",
                      fontWeight: FontWeight.bold),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.01)
                ],
              ),
              Row(
                children: [
                  const FormLabelWidget(
                      label: "Destination Country",
                      fontWeight: FontWeight.normal),
                  RoundedFormDropdown(
                    data: [
                      {"code": "1", "description": "hola"},
                      {"code": "2", "description": "hola 2"},
                    ],
                    hintText: "",
                    onSaved: (value) {},
                  )
                ],
              ),
              Row(
                children: [
                  const FormLabelWidget(
                      label: "Trip Purpose                ",
                      fontWeight: FontWeight.normal),
                  RoundedFormDropdown(
                    data: [
                      {"code": "1", "description": "hola"},
                      {"code": "2", "description": "hola 2"},
                    ],
                    hintText: "",
                    onSaved: (value) {},
                  )
                ],
              ),
              Row(
                children: [
                  const FormLabelWidget(
                      label: "Accomodation Type",
                      fontWeight: FontWeight.normal),
                  RoundedFormDropdown(
                    data: [
                      {"code": "1", "description": "hola"},
                      {"code": "2", "description": "hola 2"},
                    ],
                    hintText: "",
                    onSaved: (value) {},
                  )
                ],
              ),
              Row(
                children: [
                  const FormLabelWidget(
                      label: "Date                                  ",
                      fontWeight: FontWeight.bold),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.01)
                ],
              ),
              Row(
                children: [
                  const FormLabelWidget(
                      label: "Arrival Date                 ",
                      fontWeight: FontWeight.normal),
                  RoundedFormDatepicker(
                      onShowPicker: (context, value) async {
                        return await DateTime.now();
                      },
                      format: DateFormat.yMEd()),
                ],
              ),
              Row(
                children: [
                  const FormLabelWidget(
                      label: "Departure Date         ",
                      fontWeight: FontWeight.normal),
                  RoundedFormDatepicker(
                      onShowPicker: (context, value) async {
                        return await DateTime.now();
                      },
                      format: DateFormat.yMEd()),
                ],
              ),
              Row(
                children: [
                  const FormLabelWidget(
                      label: "Passengers Number",
                      fontWeight: FontWeight.normal),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.0001)
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
              fontSize: MediaQuery.of(context).size.width * 0.018,
              fontWeight: fontWeight,
              fontFamily: "ComicSans")),
    );
  }
}
