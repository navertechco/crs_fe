import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../index.dart';

class DestinationDetailState {
  final Rx<Map<dynamic, dynamic>> localDestination =
      Rx(getContext('destinationdata'));
  var memory = {}.obs;
  Function toMap = () {};
  Rx<String> destinationOption = "0".obs;
  Rx<String> explorationDay = "0".obs;
  Rx<String> explorationMode = "0".obs;
  Rx<String> travelRhythm = "0".obs;
  Rx<List<Map<String, dynamic>>> keyActivities = Rx([]);
  Rx<List> destinationlist = Rx([]);

 
  DestinationDetailState() {
    {
      // ignore: prefer_function_declarations_over_variables, unused_local_variable
      toMap = () {
        return {
          "exploration_days": explorationDay,
          "destination_option": destinationOption,
          "travel_rhythm": travelRhythm,
          "key_activities": keyActivities
        };
      };
    }
  }
}
