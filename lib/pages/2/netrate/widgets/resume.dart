// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../index.dart';
import '../index.dart';
import 'itinerary.dart';

/// hello
class NetRateWidget extends GetView<NetRateController> {
  const NetRateWidget({Key? key, required this.pkeys}) : super(key: key);
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
