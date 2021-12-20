// ignore_for_file: unused_field, must_be_immutable, file_names

import 'package:flutter/material.dart';
import '../state.dart';
import 'index.dart';

class TourForm extends StatefulWidget {
  TourForm({
    Key? key,
    required this.formKey,
    required this.state,
    required this.profile,
  }) : super(key: key);

  final GlobalKey formKey;
  final bool profile;
  TourState state;
  @override
  State<TourForm> createState() => _TourFormState();
}

class _TourFormState extends State<TourForm> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Padding(
        //   padding: const EdgeInsets.only(top: 0, left: 0),
        //   child: Image.asset(
        //     "assets/custom/img/lefttourinfo.png",
        //     height: double.infinity,
        //   ),
        // ),
        // Padding(
        //     padding: EdgeInsets.only(
        //         top: MediaQuery.of(context).size.height * 0.04,
        //         left: MediaQuery.of(context).size.width * 0.44),
        //     child: Image.asset(
        //       "assets/custom/img/righttourinfo.png",
        //       height: MediaQuery.of(context).size.height * 1.5,
        //     )),
        const CustomTourInformationForm(),
      ],
    );
  }
}
