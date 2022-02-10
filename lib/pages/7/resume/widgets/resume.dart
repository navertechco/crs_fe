// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import '../../../index.dart';
import '../index.dart'; 
import 'itinerary.dart'; 
/// hello
class ResumeWidget extends GetView<ResumeController> {
  const ResumeWidget({Key? key, required this.pkeys}) : super(key: key);
  final pkeys;
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = globalctx.memory.value;

    return Itinerary(
      pkeys: pkeys,
      data: data,
    );
  }
}
