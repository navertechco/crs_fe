// ignore_for_file: prefer_function_declarations_over_variables, unused_local_variable

import 'package:flutter/material.dart';
import '../index.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart'; 

// ignore: must_be_immutable
class CustomStarDestinationForm extends StatelessWidget {
  CustomStarDestinationForm({
    Key? key,
    required this.index,
    required this.destination,
    required this.ctrl,
    required this.formKey,
  }) : super(key: key);
  final String destination;
  final DestinationDetailController ctrl;
  GlobalKey<FormState> formKey;
  final index;

  @override
  Widget build(BuildContext context) {
    var tour = getContext("tour");
    var ctx = globalctx.context.value;

    Rx<int> explorationDay = Rx(int.parse(getFormValue(
            globalctx.memory["destinations"], index, "explorationDay", "0") ??
        "0"));

    List<String> keyActivities = getFormValue(
        globalctx.memory["destinations"], index, "key_activities", <String>[]);
    Rx<String> subDestination =
        Rx(getFormValue(globalctx.memory["destinations"], index, "sub", "0"));
    List<Map<String, dynamic>> explorationdDays =
        findCatalog("exploration_days");

    Rx<List> trCatalog = Rx(findCatalog("travel_rhythm"));
    var destData = globalctx.memory["destinations"][index.toString()];
    var type = globalctx.states["destinations"][index]["type"];
    RxString explorationMode = getFormValue(
            globalctx.memory["destinations"], index, "explorationMode", "0")
        .toString()
        .obs;
    RxString cruiseOptions = getFormValue(
            globalctx.memory["destinations"], index, "cruiseOptions", "0")
        .toString()
        .obs;
    RxInt minExpDay = (explorationMode.value == "1"
            ? 2
            : explorationMode.value == "2"
                ? 4
                : 0)
        .obs;

    Function validateMixedDate =
        (DateTime memoryDate, DateTime compareDate, DateTime currentDate) {
      if (compareDate == memoryDate ||
          currentDate.isBefore(compareDate) ||
          currentDate.isAfter(compareDate)) {
        return currentDate;
      }
      return compareDate;
    };

    Function validateGalapagosTR = () {
      if (destination == "galapagos") {
        setFormValue(
            globalctx.memory["destinations"], index, "travel_rhythm", "3");
      }
    };

    return Form(
      key: formKey,
      child: Column(
        children: [
          DestinationIndexControlWidget(),
          DaysControlWidget(),
          DestFormmControlsWidget(
              explorationDay: explorationDay,
              destination: destination,
              index: index,
              type: type,
              explorationMode: explorationMode,
              keyActivities: keyActivities),
        ],
      ),
    );
  }
}
