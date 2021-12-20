// ignore_for_file: unused_field, must_be_immutable, file_names

import 'package:flutter/material.dart';
import '../state.dart';
import 'index.dart';

class RightWidget extends StatefulWidget {
  RightWidget({
    Key? key,
    required this.formKey,
    required this.state,
    required this.profile,
  }) : super(key: key);

  final GlobalKey formKey;
  final bool profile;
  TourState state;
  @override
  State<RightWidget> createState() => _RightWidgetState();
}

class _RightWidgetState extends State<RightWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomTourInformationForm();
  }
}
