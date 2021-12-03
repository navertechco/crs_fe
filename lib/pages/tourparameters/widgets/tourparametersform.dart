// ignore_for_file: unused_field, must_be_immutable, file_names

import 'package:flutter/material.dart'; 
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
        const SingleChildScrollView(child: Text("") ,),
        Column( )
      ],
    );
  }
}
