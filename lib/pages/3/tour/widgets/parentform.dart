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
       
        const CustomTourInformationForm(),
      ],
    );
  }
}
