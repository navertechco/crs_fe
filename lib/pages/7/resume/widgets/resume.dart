// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter/material.dart';
import '../index.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';
import 'package:naver_crs/index.dart';
import 'itinerary.dart';

/// hello
class ResumeWidget extends GetView<ResumeController> {
  const ResumeWidget({Key? key, required this.pkeys}) : super(key: key);
  final pkeys;
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = memory;

    return Itinerary(
      pkeys: pkeys,
      data: data,
    );
  }
}
